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

namespace HAM_API.Controllers
{
    public class RoleController : ApiController
    {
        private hapdbEntities db = new hapdbEntities();

        // GET: api/Role
        public IQueryable<tbl_role> Gettbl_role()
        {
            return db.tbl_role;
        }

        // GET: api/Role/5
        [ResponseType(typeof(tbl_role))]
        public IHttpActionResult Gettbl_role(int id)
        {
            tbl_role tbl_role = db.tbl_role.Find(id);
            if (tbl_role == null)
            {
                return NotFound();
            }

            return Ok(tbl_role);
        }

        // PUT: api/Role/5
        [ResponseType(typeof(void))]
        public IHttpActionResult Puttbl_role(int id, tbl_role tbl_role)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            if (id != tbl_role.id)
            {
                return BadRequest();
            }

            db.Entry(tbl_role).State = EntityState.Modified;

            try
            {
                db.SaveChanges();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!tbl_roleExists(id))
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

        // POST: api/Role
        [ResponseType(typeof(tbl_role))]
        public IHttpActionResult Posttbl_role(tbl_role tbl_role)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            db.tbl_role.Add(tbl_role);
            db.SaveChanges();

            return CreatedAtRoute("DefaultApi", new { id = tbl_role.id }, tbl_role);
        }

        // DELETE: api/Role/5
        [ResponseType(typeof(tbl_role))]
        public IHttpActionResult Deletetbl_role(int id)
        {
            tbl_role tbl_role = db.tbl_role.Find(id);
            if (tbl_role == null)
            {
                return NotFound();
            }

            db.tbl_role.Remove(tbl_role);
            db.SaveChanges();

            return Ok(tbl_role);
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }

        private bool tbl_roleExists(int id)
        {
            return db.tbl_role.Count(e => e.id == id) > 0;
        }
    }
}