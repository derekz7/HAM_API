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
        [HttpGet]
        public IQueryable<tbl_role> GetAllRoles()
        {
            return db.tbl_role;
        }

        [HttpGet]
        // GET: api/Role/5
        [ResponseType(typeof(tbl_role))]
        public IHttpActionResult GetRoleById(int id)
        {
            tbl_role role = db.tbl_role.Where(x => x.id == id).FirstOrDefault();    
            if (role == null)
            {
                return NotFound();
            }

            return Ok(role);
        }


        // PUT: api/Role/5
        [HttpPut]
        [ResponseType(typeof(void))]
        public IHttpActionResult UpdateRole(int id, tbl_role role)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            if (id != role.id)
            {
                return BadRequest();
            }

            db.Entry(role).State = EntityState.Modified;

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
        public IHttpActionResult Posttbl_role(tbl_role role)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            db.tbl_role.Add(role);
            try
            {
                db.SaveChanges();
            }
            catch (DbUpdateException)
            {
                if (tbl_roleExists(role.id))
                {
                    return Conflict();
                }
                else
                {
                    throw;
                }
            }

            return CreatedAtRoute("DefaultApi", new { id = role.id }, role);
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