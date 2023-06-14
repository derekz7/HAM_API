using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using HAM_API.Models;

namespace HAM_API.Controllers
{
    public class BookingController : Controller
    {
        private DBContext db = new DBContext();

        // GET: Booking
        public ActionResult Index()
        {
            var tbl_booking = db.tbl_booking.Include(t => t.tbl_doctor).Include(t => t.tbl_patient).Include(t => t.tbl_service).Include(t => t.tbl_user);
            return View(tbl_booking.ToList());
        }

        public ActionResult Pending()
        {
            List<tbl_booking> results = db.tbl_booking.Where(t => t.status == "Pending" || t.status == "Chờ khám")
                .Include(t => t.tbl_doctor)
                .Include(t => t.tbl_patient)
                .Include(t => t.tbl_service)
                .Include(t => t.tbl_user).ToList();
            return View(results);
        }
        public ActionResult Complete()
        {
            List<tbl_booking> results = db.tbl_booking.Where(t => t.status == "Success" || t.status == "Đã khám")
                .Include(t => t.tbl_doctor)
                .Include(t => t.tbl_patient)
                .Include(t => t.tbl_service)
                .Include(t => t.tbl_user).ToList();
            return View(results);
        }
        public ActionResult Canceled()
        {
            List<tbl_booking> results = db.tbl_booking.Where(t => t.status == "Canceled" || t.status == "Đã hủy")
                .Include(t => t.tbl_doctor)
                .Include(t => t.tbl_patient)
                .Include(t => t.tbl_service)
                .Include(t => t.tbl_user).ToList();
            return View(results);
        }

        public ActionResult Search(string searchString)
        {
            var users = db.tbl_user.ToList();

            if (!string.IsNullOrEmpty(searchString))
            {
                users = users.Where(u => u.name.Contains(searchString) || u.username.Contains(searchString)).ToList();
            }

            return View("Index", users);
        }
        public ActionResult CompleteSearch(string searchString)
        {
            List<tbl_booking> books = db.tbl_booking.Where(x => x.status == "Đã khám").ToList();

            if (!string.IsNullOrEmpty(searchString))
            {
                books = books.Where(u => u.tbl_patient.pt_name.Contains(searchString) || u.order_num.ToString().Contains(searchString)).ToList();
            }

            return View("Index", books);
        }
        public ActionResult CanceledSearch(string searchString)
        {
            List<tbl_booking> books = db.tbl_booking.Where(x => x.status == "Đã khám").ToList();

            if (!string.IsNullOrEmpty(searchString))
            {
                books = books.Where(u => u.tbl_patient.pt_name.Contains(searchString) || u.order_num.ToString().Contains(searchString)).ToList();
            }

            return View("Index", books);
        }
        public ActionResult PendingSearch(string searchString)
        {
            List<tbl_booking> books = db.tbl_booking.Where(x => x.status == "Đã khám").ToList();

            if (!string.IsNullOrEmpty(searchString))
            {
                books = books.Where(u => u.tbl_patient.pt_name.Contains(searchString) || u.order_num.ToString().Contains(searchString)).ToList();
            }

            return View("Index", books);
        }

        // GET: Booking/Details/5
        public ActionResult Details(string id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            tbl_booking tbl_booking = db.tbl_booking.Find(id);
            if (tbl_booking == null)
            {
                return HttpNotFound();
            }
            return View(tbl_booking);
        }

        // GET: Booking/Create
        public ActionResult Create()
        {
            ViewBag.dc_id = new SelectList(db.tbl_doctor, "id", "name");
            ViewBag.pt_id = new SelectList(db.tbl_patient, "id", "pt_name");
            ViewBag.sv_id = new SelectList(db.tbl_service, "id", "name");
            ViewBag.user_id = new SelectList(db.tbl_user, "id", "username");
            return View();
        }

        // POST: Booking/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "order_num,date,time,price,status,pt_id,user_id,dc_id,sv_id")] tbl_booking tbl_booking)
        {
            string id = "bk-" + Guid.NewGuid().ToString("N").Substring(0, 17);
            string idap = "ap-" + Guid.NewGuid().ToString("N").Substring(0, 17);
            tbl_booking.id = id;
            int orderNum = new Random().Next(0, 100);
            tbl_booking.order_num = orderNum;
            if (ModelState.IsValid)
            {
                tbl_appointment apointment = new tbl_appointment();
                apointment.id = idap;
                apointment.bid = tbl_booking.id;
                apointment.uid = tbl_booking.user_id;
                apointment.dcid = tbl_booking.dc_id;
                apointment.dcName = tbl_booking.tbl_doctor.name;
                apointment.time = tbl_booking.time;
                apointment.date = tbl_booking.date;
                apointment.price = tbl_booking.price;
                apointment.ptName = tbl_booking.tbl_patient.pt_name;
                apointment.orderNum = orderNum;
                apointment.serviceName = tbl_booking.tbl_service.name;
                apointment.room = tbl_booking.tbl_doctor.room;
                apointment.status = tbl_booking.status;
                apointment.depName = tbl_booking.tbl_doctor.tbl_department.name;
                db.tbl_appointment.Add(apointment);
                db.tbl_booking.Add(tbl_booking);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.dc_id = new SelectList(db.tbl_doctor, "id", "name", tbl_booking.dc_id);
            ViewBag.pt_id = new SelectList(db.tbl_patient.Where(p => p.user_id == tbl_booking.user_id), "id", "pt_name", tbl_booking.pt_id);
            ViewBag.sv_id = new SelectList(db.tbl_service, "id", "name", tbl_booking.sv_id);
            ViewBag.user_id = new SelectList(db.tbl_user, "id", "username", tbl_booking.user_id);
            return View(tbl_booking);
        }

        // GET: Booking/Edit/5
        public ActionResult Edit(string id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            tbl_booking tbl_booking = db.tbl_booking.Find(id);
            if (tbl_booking == null)
            {
                return HttpNotFound();
            }
            ViewBag.dc_id = tbl_booking.dc_id;
            ViewBag.order_num = tbl_booking.order_num;
            ViewBag.pt_id = new SelectList(db.tbl_patient.Where(x => x.user_id == tbl_booking.user_id), "id", "pt_name", tbl_booking.pt_id);
            ViewBag.sv_id = new SelectList(db.tbl_service, "id", "name", tbl_booking.sv_id);
            ViewBag.user_id = tbl_booking.user_id;
            return View(tbl_booking);
        }

        // POST: Booking/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "id,date,time,status,pt_id,sv_id,dc_id,order_num,user_id")] tbl_booking tbl_booking)
        {
            if (ModelState.IsValid)
            {
                tbl_booking.price = db.tbl_service.Find(tbl_booking.sv_id).price;
                tbl_patient pt = db.tbl_patient.Find(tbl_booking.pt_id);
                tbl_appointment app = db.tbl_appointment.Where(x => x.bid == tbl_booking.id).First();
                app.uid = tbl_booking.user_id;
                app.time = tbl_booking.time;
                app.date = tbl_booking.date;
                app.price = tbl_booking.price;
                app.orderNum = tbl_booking.order_num;
                app.status = tbl_booking.status;
                app.ptName = pt.pt_name;
                
                db.Entry(app).State = EntityState.Modified;
                db.Entry(tbl_booking).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.dc_id = tbl_booking.dc_id;
            ViewBag.order_num = tbl_booking.order_num;
            ViewBag.pt_id = new SelectList(db.tbl_patient.Where(x => x.user_id == tbl_booking.user_id), "id", "pt_name", tbl_booking.pt_id);
            ViewBag.sv_id = new SelectList(db.tbl_service, "id", "name", tbl_booking.sv_id);
            ViewBag.user_id = tbl_booking.user_id;
            return View(tbl_booking);
        }


        public ActionResult ChangeState(string id)
        {
            tbl_booking booking = db.tbl_booking.Find(id);
            tbl_appointment app = db.tbl_appointment.Where(x => x.bid == id).First();
            booking.status = "Đã khám";
            app.status = booking.status;

            db.Entry(booking).State = EntityState.Modified;
            db.Entry(app).State = EntityState.Modified;
            db.SaveChanges();
            return RedirectToAction("Pending");
        }

        public ActionResult Cancel(string id)
        {
            tbl_booking booking = db.tbl_booking.Find(id);
            tbl_appointment app = db.tbl_appointment.Where(x => x.bid == id).First();
            booking.status = "Canceled";
            app.status = "Canceled";
            db.Entry(booking).State = EntityState.Modified;
            db.Entry(app).State = EntityState.Modified;
            db.SaveChanges();
            return RedirectToAction("Pending");
        }

        // GET: Booking/Delete/5
        public ActionResult Delete(string id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }

            tbl_booking tbl_booking = db.tbl_booking.Find(id);
        
            if (tbl_booking == null)
            {
                return HttpNotFound();
            }
            return View(tbl_booking);
        }

        // POST: Booking/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(string id)
        {
            tbl_booking tbl_booking = db.tbl_booking.Find(id);
            tbl_appointment app = db.tbl_appointment.Where(x => x.bid == id).First();
            db.tbl_appointment.Remove(app);
            db.tbl_booking.Remove(tbl_booking);
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
