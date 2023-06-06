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
    public class DoctorController : Controller
    {
        private DBContext db = new DBContext();

        // GET: Doctor
        public ActionResult Index()
        {
            var tbl_doctor = db.tbl_doctor.Include(t => t.tbl_department);
            return View(tbl_doctor.ToList());
        }

        public ActionResult Search(string searchString)
        {
            var doctors = db.tbl_doctor.ToList();

            if (!string.IsNullOrEmpty(searchString))
            {
                doctors = doctors.Where(u => u.name.Contains(searchString) || u.tbl_department.name.Contains(searchString)).ToList();
            }

            return View("Index", doctors);
        }

        // GET: Doctor/Details/5
        public ActionResult Details(string id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            tbl_doctor tbl_doctor = db.tbl_doctor.Find(id);
            if (tbl_doctor == null)
            {
                return HttpNotFound();
            }
            return View(tbl_doctor);
        }

        // GET: Doctor/Create
        public ActionResult Create()
        {
            ViewBag.dep_id = new SelectList(db.tbl_department, "id", "name");
            return View();
        }

        // POST: Doctor/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "name,room,dep_id, imgUrl")] tbl_doctor tbl_doctor)
        {
            string id = "dc-" + Guid.NewGuid().ToString("N").Substring(0, 17);
            tbl_doctor.id = id;
            if (ModelState.IsValid)
            {
                db.tbl_doctor.Add(tbl_doctor);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.dep_id = new SelectList(db.tbl_department, "id", "name", tbl_doctor.dep_id);
            return View(tbl_doctor);
        }

        // GET: Doctor/Edit/5
        public ActionResult Edit(string id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            tbl_doctor tbl_doctor = db.tbl_doctor.Find(id);
            if (tbl_doctor == null)
            {
                return HttpNotFound();
            }
            ViewBag.dep_id = new SelectList(db.tbl_department, "id", "name", tbl_doctor.dep_id);
            return View(tbl_doctor);
        }

        // POST: Doctor/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "id,name,room,dep_id, imgUrl")] tbl_doctor tbl_doctor)
        {
            if (ModelState.IsValid)
            {
                db.Entry(tbl_doctor).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.dep_id = new SelectList(db.tbl_department, "id", "name", tbl_doctor.dep_id);
            return View(tbl_doctor);
        }

        // GET: Doctor/Delete/5
        public ActionResult Delete(string id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            tbl_doctor tbl_doctor = db.tbl_doctor.Find(id);
            if (tbl_doctor == null)
            {
                return HttpNotFound();
            }
            return View(tbl_doctor);
        }

        // POST: Doctor/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(string id)
        {
            tbl_doctor tbl_doctor = db.tbl_doctor.Find(id);
            db.tbl_doctor.Remove(tbl_doctor);
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
