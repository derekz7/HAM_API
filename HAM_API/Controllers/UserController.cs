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


        // GET: User/Details/5
        public ActionResult Details(string id)
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
                var emailExists = db.tbl_user.Count(x => x.email == tbl_user.email);
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
