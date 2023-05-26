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
    public class ServiceController : Controller
    {
        private DBContext db = new DBContext();

        // GET: Service
        public ActionResult Index()
        {
            return View(db.tbl_service.ToList());
        }

        // GET: Service/Details/5
        public ActionResult Details(string id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            tbl_service tbl_service = db.tbl_service.Find(id);
            if (tbl_service == null)
            {
                return HttpNotFound();
            }
            return View(tbl_service);
        }

        // GET: Service/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: Service/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "name,description,price")] tbl_service tbl_service)
        {   string id = "sv-" + Guid.NewGuid().ToString("N").Substring(0, 10);
            tbl_service.id = id;
            if (ModelState.IsValid)
            {
                db.tbl_service.Add(tbl_service);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            return View(tbl_service);
        }

        // GET: Service/Edit/5
        public ActionResult Edit(string id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            tbl_service tbl_service = db.tbl_service.Find(id);
            if (tbl_service == null)
            {
                return HttpNotFound();
            }
            return View(tbl_service);
        }

        // POST: Service/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "id,name,description,price")] tbl_service tbl_service)
        {
            if (ModelState.IsValid)
            {
                db.Entry(tbl_service).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(tbl_service);
        }

        // GET: Service/Delete/5
        public ActionResult Delete(string id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            tbl_service tbl_service = db.tbl_service.Find(id);
            if (tbl_service == null)
            {
                return HttpNotFound();
            }
            return View(tbl_service);
        }

        // POST: Service/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(string id)
        {
            tbl_service tbl_service = db.tbl_service.Find(id);
            db.tbl_service.Remove(tbl_service);
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
