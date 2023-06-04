using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.IO;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using HAM_API.Models;
using OfficeOpenXml;

namespace HAM_API.Controllers
{
    public class UserController : Controller
    {
        private DBContext db = new DBContext();

        // GET: User
        public ActionResult Index()
        {
            var tbl_user = db.tbl_user.Include(t => t.tbl_role);
            return View(tbl_user.ToList());
        }

        [HttpGet]
        public ActionResult CreatePatient(string id)
        {
            // Get the user with the specified ID from the database
            tbl_user user = db.tbl_user.Find(id);

            // Create a new patient with the user ID
            tbl_patient patient = new tbl_patient()
            {
                user_id = user.id
            };

            // Pass the patient object to the Create view of the Patient controller
            return RedirectToAction("Create", "Patient", patient);
        }

        public ActionResult LoadData()
        {
            List<tbl_user> users = ReadExcelToList(@"D:\Project\Đồ án tốt nghiệp\Data.xlsx");
            db.tbl_user.AddRange(users);
            db.SaveChanges();
            return View("Index",users);
        }

        public List<tbl_user> ReadExcelToList(string filePath)
        {
            List<tbl_user> userList = new List<tbl_user>();

            try
            {
                FileInfo file = new FileInfo(filePath);
                using (ExcelPackage package = new ExcelPackage(file))
                {
                    ExcelPackage.LicenseContext = LicenseContext.NonCommercial;
                    ExcelWorksheet worksheet = package.Workbook.Worksheets[0];

                    int rowCount = worksheet.Dimension.Rows;
                    int colCount = worksheet.Dimension.Columns;

                    // Assuming the first row contains headers
                    int startRow = 1;

                    for (int row = startRow; row <= rowCount; row++)
                    {
                        string id = "u-" + Guid.NewGuid().ToString().Substring(0, 15);
                        tbl_user user = new tbl_user();
                        user.id = id;
                        user.role_id = 2;
                        user.name = worksheet.Cells[row, 1]?.Value?.ToString();
                        user.username = worksheet.Cells[row, 4]?.Value?.ToString();
                        user.email = worksheet.Cells[row, 5]?.Value?.ToString();
                        user.pw = worksheet.Cells[row, 6]?.Value?.ToString();
                        user.p_number = worksheet.Cells[row, 7]?.Value?.ToString();
                        user.img = "https://imgur.com/yWLxOxv.png";
                        userList.Add(user);
                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }

            return userList;
        }

       



        // GET: User/Details/5
        public ActionResult Details(string id)
        {   
            List<tbl_booking> bookinglist = new List<tbl_booking>();
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            tbl_user tbl_user = db.tbl_user.Find(id);
            if (tbl_user == null)
            {
                return HttpNotFound();
            }
            ViewBag.bookingList = db.tbl_booking.Where(x => x.user_id == id).ToList();
            ViewBag.patientList = db.tbl_patient.Where(x => x.user_id.Equals(id)).ToList();
            return View(tbl_user);
        }

        // GET: User/Create
        public ActionResult Create()
        {
            ViewBag.role_id = new SelectList(db.tbl_role, "id", "role_name");
            return View();
        }

        // POST: User/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "username, name ,email, pw, role_id, p_number, img")] tbl_user tbl_user)
        {
            string id = "u-" + Guid.NewGuid().ToString().Substring(0, 15);
            tbl_user.id = id;

            if (ModelState.IsValid)
            {
                bool usernameExits = db.tbl_user.Any(x => x.username == tbl_user.username);
                var emailExists = db.tbl_user.Count(x => x.email == tbl_user.email);
                if (usernameExits)
                {
                    ModelState.AddModelError("username", "This username already exists.");
                    ViewBag.role_id = new SelectList(db.tbl_role, "id", "role_name", tbl_user.role_id);
                    return View(tbl_user);
                }
                if (emailExists > 0 && tbl_user.email != null)
                {
                    ModelState.AddModelError("email", "The email already exists.");
                    ViewBag.role_id = new SelectList(db.tbl_role, "id", "role_name", tbl_user.role_id);
                    return View(tbl_user);
                }

                db.tbl_user.Add(tbl_user);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.role_id = new SelectList(db.tbl_role, "id", "role_name", tbl_user.role_id);
            return View(tbl_user);
        }

        // GET: User/Edit/5
        public ActionResult Edit(string id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            tbl_user tbl_user = db.tbl_user.Find(id);
            if (tbl_user == null)
            {
                return HttpNotFound();
            }
            ViewBag.role_id = new SelectList(db.tbl_role, "id", "role_name", tbl_user.role_id);
            return View(tbl_user);
        }

        // POST: User/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "id,username, name ,email, pw, role_id, p_number, img")] tbl_user tbl_user)
        {
            if (ModelState.IsValid)
            {
                var emailExists = db.tbl_user.Count(x => x.email == tbl_user.email && x.username != tbl_user.username);
                if (emailExists > 0 && tbl_user.email != null)
                {
                    ModelState.AddModelError("email", "The email already exists.");
                    ViewBag.role_id = new SelectList(db.tbl_role, "id", "role_name", tbl_user.role_id);
                    return View(tbl_user);
                }
                db.Entry(tbl_user).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.role_id = new SelectList(db.tbl_role, "id", "role_name", tbl_user.role_id);
            return View(tbl_user);
        }

        // GET: User/Delete/5
        public ActionResult Delete(string id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            tbl_user tbl_user = db.tbl_user.Find(id);
            if (tbl_user == null)
            {
                return HttpNotFound();
            }
            return View(tbl_user);
        }

        // POST: User/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(string id)
        {
            tbl_user tbl_user = db.tbl_user.Find(id);
            db.tbl_user.Remove(tbl_user);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }

    }

}
