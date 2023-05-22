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
    public class DepartmentController : ApiController
    {
        private hapdbEntities db = new hapdbEntities();

        // GET: api/Department
        public IQueryable<tbl_department> Gettbl_department()
        {
            return db.tbl_department;
        }

        // GET: api/Department/5
        [ResponseType(typeof(tbl_department))]
        public IHttpActionResult Gettbl_department(int id)
        {
            tbl_department tbl_department = db.tbl_department.Find(id);
            if (tbl_department == null)
            {
                return NotFound();
            }

            return Ok(tbl_department);
        }

        // PUT: api/Department/5
        [ResponseType(typeof(void))]
        public IHttpActionResult Puttbl_department(int id, tbl_department tbl_department)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            if (id != tbl_department.id)
            {
                return BadRequest();
            }

            db.Entry(tbl_department).State = EntityState.Modified;

            try
            {
                db.SaveChanges();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!tbl_departmentExists(id))
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

        // POST: api/Department
        [ResponseType(typeof(tbl_department))]
        public IHttpActionResult Posttbl_department(tbl_department tbl_department)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            db.tbl_department.Add(tbl_department);
            db.SaveChanges();

            return CreatedAtRoute("DefaultApi", new { id = tbl_department.id }, tbl_department);
        }

        // DELETE: api/Department/5
        [ResponseType(typeof(tbl_department))]
        public IHttpActionResult Deletetbl_department(int id)
        {
            tbl_department tbl_department = db.tbl_department.Find(id);
            if (tbl_department == null)
            {
                return NotFound();
            }

            db.tbl_department.Remove(tbl_department);
            db.SaveChanges();

            return Ok(tbl_department);
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }

        private bool tbl_departmentExists(int id)
        {
            return db.tbl_department.Count(e => e.id == id) > 0;
        }
    }
}