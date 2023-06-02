using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Data.Entity.Infrastructure;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Web.Http.Description;
using HAM_API.Models;

namespace HAM_API.Controllers.api
{
    public class NewsController : ApiController
    {
        private DBContext db = new DBContext();

        // GET: api/News
        public IQueryable<tbl_news> GetAllNews()
        {
            return db.tbl_news;
        }

        public List<tbl_news> Get3NewestNews()
        {
            List<tbl_news> newestNews = db.tbl_news.OrderByDescending(n => n.postDate).Take(3).ToList();
            return newestNews;

        }

        // GET: api/News/5
        [ResponseType(typeof(tbl_news))]
        public IHttpActionResult GetPostById(string id)
        {
            tbl_news tbl_news = db.tbl_news.Find(id);
            if (tbl_news == null)
            {
                return NotFound();
            }

            return Ok(tbl_news);
        }

        // PUT: api/News/5
        [ResponseType(typeof(void))]
        public IHttpActionResult UpdatePost(string id, tbl_news tbl_news)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            if (id != tbl_news.id)
            {
                return BadRequest();
            }

            db.Entry(tbl_news).State = EntityState.Modified;

            try
            {
                db.SaveChanges();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!tbl_newsExists(id))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }

            return StatusCode(HttpStatusCode.NoContent);
        }

        // POST: api/News
        [ResponseType(typeof(tbl_news))]
        public IHttpActionResult CreatePost(tbl_news tbl_news)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            db.tbl_news.Add(tbl_news);

            try
            {
                db.SaveChanges();
            }
            catch (DbUpdateException)
            {
                if (tbl_newsExists(tbl_news.id))
                {
                    return Conflict();
                }
                else
                {
                    throw;
                }
            }

            return CreatedAtRoute("DefaultApi", new { id = tbl_news.id }, tbl_news);
        }

        // DELETE: api/News/5
        [ResponseType(typeof(tbl_news))]
        public IHttpActionResult DeletePost(string id)
        {
            tbl_news tbl_news = db.tbl_news.Find(id);
            if (tbl_news == null)
            {
                return NotFound();
            }

            db.tbl_news.Remove(tbl_news);
            db.SaveChanges();

            return Ok(tbl_news);
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }

        private bool tbl_newsExists(string id)
        {
            return db.tbl_news.Count(e => e.id == id) > 0;
        }
    }
}