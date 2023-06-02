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
    public class PatientController : Controller
    {
        private DBContext db = new DBContext();

        // GET: Patient
        public ActionResult Index()
        {
            var tbl_patient = db.tbl_patient.Include(t => t.tbl_user);
            return View(tbl_patient.ToList());
        }

        public ActionResult Search(string searchString)
        {
            var patients = db.tbl_patient.ToList();

            if (!string.IsNullOrEmpty(searchString))
            {
                patients = patients.Where(u => u.pt_name.Contains(searchString) || u.tbl_user.username.Contains(searchString)).ToList();
            }

            return View("Index", patients);
        }

        // GET: Patient/Details/5
        public ActionResult Details(string id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            tbl_patient tbl_patient = db.tbl_patient.Find(id);
            if (tbl_patient == null)
            {
                return HttpNotFound();
            }
            return View(tbl_patient);
        }

        // GET: Patient/Create
        public ActionResult Create(string userid)
        {
            ViewBag.user_id = userid;
            return View(new tbl_patient { user_id = userid });
        }

        // POST: Patient/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "id,pt_name,dob,gender,job,address,user_id")] tbl_patient tbl_patient)
        {
            string id = "pt-" + Guid.NewGuid().ToString("N").Substring(0, 17);
            tbl_patient.id = id;
            if (ModelState.IsValid)
            {
                db.tbl_patient.Add(tbl_patient);
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(tbl_patient);
        }

        // GET: Patient/Edit/5
        public ActionResult Edit(string id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            tbl_patient tbl_patient = db.tbl_patient.Find(id);
            if (tbl_patient == null)
            {
                return HttpNotFound();
            }
            ViewBag.user_id = new SelectList(db.tbl_user, "id", "username", tbl_patient.user_id);
            return View(tbl_patient);
        }

        // POST: Patient/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "id,pt_name,dob,gender,job,address,user_id")] tbl_patient tbl_patient)
        {
            if (ModelState.IsValid)
            {
                db.Entry(tbl_patient).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.user_id = new SelectList(db.tbl_user, "id", "username", tbl_patient.user_id);
            return View(tbl_patient);
        }

        // GET: Patient/Delete/5
        public ActionResult Delete(string id)
        {
            tbl_patient patient = db.tbl_patient.Find(id);
            if (patient == null)
            {
                return HttpNotFound();
            }

            // Check if there are any bookings associated with the patient
            bool hasBookings = db.tbl_booking.Any(b => b.pt_id == id);

            if (hasBookings)
            {
                // Patient has associated bookings, show the cannot delete page
                return RedirectToAction("CannotDeletePatient",patient);
            }

            return View(patient);
        }

        // POST: Patient/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(string id)
        {
            tbl_patient patient = db.tbl_patient.Find(id);
            List<tbl_patientRelative> relations = db.tbl_patientRelative.Where(p => p.pt_id == id).ToList();
            db.tbl_patientRelative.RemoveRange(relations);
            db.tbl_patient.Remove(patient);
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

        public ActionResult CannotDeletePatient(string id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            tbl_patient tbl_patient = db.tbl_patient.Find(id);
            if (tbl_patient == null)
            {
                return HttpNotFound();
            }
            return View(tbl_patient);
        }
    }
}
