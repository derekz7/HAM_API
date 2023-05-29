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
            tbl_booking.id = id;
            List<tbl_booking> bookings = db.tbl_booking.Where(p => p.date == tbl_booking.date).ToList();
            int orderNum = bookings.Count;
            tbl_booking.order_num = orderNum + 1;
            if (ModelState.IsValid)
            {
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
            ViewBag.dc_id = new SelectList(db.tbl_doctor, "id", "name", tbl_booking.dc_id);
            ViewBag.pt_id = new SelectList(db.tbl_patient, "id", "pt_name", tbl_booking.pt_id);
            ViewBag.sv_id = new SelectList(db.tbl_service, "id", "name", tbl_booking.sv_id);
            ViewBag.user_id = new SelectList(db.tbl_user, "id", "username", tbl_booking.user_id);
            return View(tbl_booking);
        }

        // POST: Booking/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "id,order_num,date,time,price,status,pt_id,user_id,dc_id,sv_id")] tbl_booking tbl_booking)
        {
            if (ModelState.IsValid)
            {
                db.Entry(tbl_booking).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.dc_id = new SelectList(db.tbl_doctor, "id", "name", tbl_booking.dc_id);
            ViewBag.pt_id = new SelectList(db.tbl_patient, "id", "pt_name", tbl_booking.pt_id);
            ViewBag.sv_id = new SelectList(db.tbl_service, "id", "name", tbl_booking.sv_id);
            ViewBag.user_id = new SelectList(db.tbl_user, "id", "username", tbl_booking.user_id);
            return View(tbl_booking);
        }


        public ActionResult ChangeState(string id)
        {
            tbl_booking booking = db.tbl_booking.Find(id);
            booking.status = "Đã khám";
            db.Entry(booking).State = EntityState.Modified;
            db.SaveChanges();
            return RedirectToAction("Pending");
        }

        public ActionResult Cancel(string id)
        {
            tbl_booking booking = db.tbl_booking.Find(id);
            booking.status = "Canceled";
            db.Entry(booking).State = EntityState.Modified;
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
