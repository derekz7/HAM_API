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
    public class NewsController : Controller
    {
        private DBContext db = new DBContext();

        // GET: News
        public ActionResult Index()
        {
            return View(db.tbl_news.ToList());
        }

        // GET: News/Details/5
        public ActionResult Details(string id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            tbl_news tbl_news = db.tbl_news.Find(id);
            if (tbl_news == null)
            {
                return HttpNotFound();
            }
            return View(tbl_news);
        }

        // GET: News/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: News/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "title,body,imgUrl,Url")] tbl_news tbl_news)
        {
            string id = "new" + Guid.NewGuid().ToString().Substring(0,17);
            if (ModelState.IsValid)
            {
                tbl_news.id = id;
                tbl_news.postDate = DateTime.Now.Date.ToString("dd/MM/yyyy");
                db.tbl_news.Add(tbl_news);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            return View(tbl_news);
        }

        // GET: News/Edit/5
        public ActionResult Edit(string id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            tbl_news tbl_news = db.tbl_news.Find(id);
            if (tbl_news == null)
            {
                return HttpNotFound();
            }
            return View(tbl_news);
        }

        // POST: News/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "id,title,body,imgUrl,Url")] tbl_news tbl_news)
        {
            if (ModelState.IsValid)
            {
                db.Entry(tbl_news).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(tbl_news);
        }

        // GET: News/Delete/5
        public ActionResult Delete(string id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            tbl_news tbl_news = db.tbl_news.Find(id);
            if (tbl_news == null)
            {
                return HttpNotFound();
            }
            return View(tbl_news);
        }

        // POST: News/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(string id)
        {
            tbl_news tbl_news = db.tbl_news.Find(id);
            db.tbl_news.Remove(tbl_news);
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
