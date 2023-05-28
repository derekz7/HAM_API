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
    public class DepartmentController : Controller
    {
        private DBContext db = new DBContext();

        // GET: Department
        public ActionResult Index()
        {
            return View(db.tbl_department.ToList());
        }

        [HttpPost]
        public ActionResult Search(string keyword)
        {
            var departments = db.tbl_department.Where(d => d.name.Contains(keyword)).ToList();
            return PartialView("_DepartmentTable", departments);
        }

        // GET: Department/Details/5
        public ActionResult Details(string id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            tbl_department tbl_department = db.tbl_department.Where(x => x.id == id).First();
            if (tbl_department == null)
            {
                return HttpNotFound();
            }
            return View(tbl_department);
        }

        // GET: Department/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: Department/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "name,description, img")] tbl_department tbl_department)
        {
            string id = "dep-" + Guid.NewGuid().ToString().Substring(0, 15);
            tbl_department.id = id;
            if (ModelState.IsValid)
            {
                db.tbl_department.Add(tbl_department);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            return View(tbl_department);
        }

        // GET: Department/Edit/5
        public ActionResult Edit(string id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            tbl_department tbl_department = db.tbl_department.Where(x => x.id == id).First();
            if (tbl_department == null)
            {
                return HttpNotFound();
            }
            return View(tbl_department);
        }

        // POST: Department/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "id,name,description,img")] tbl_department tbl_department)
        {
            if (ModelState.IsValid)
            {
                db.Entry(tbl_department).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(tbl_department);
        }

        // GET: Department/Delete/5
        public ActionResult Delete(string id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            tbl_department tbl_department = db.tbl_department.Where(x => x.id == id).FirstOrDefault();
            if (tbl_department == null)
            {
                return HttpNotFound();
            }
            return View(tbl_department);
        }

        // POST: Department/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(string id)
        {
            tbl_department tbl_department = db.tbl_department.Where(x => x.id == id).FirstOrDefault();
            db.tbl_department.Remove(tbl_department);
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
