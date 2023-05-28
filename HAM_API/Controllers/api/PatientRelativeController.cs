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
    public class PatientRelativeController : ApiController
    {
        private DBContext db = new DBContext();

        // GET: api/PatientRelative
        public IQueryable<tbl_patientRelative> GetAllPatientsRelative()
        {
            return db.tbl_patientRelative;
        }

        // GET: api/PatientRelative/5
        [ResponseType(typeof(tbl_patientRelative))]
        public IHttpActionResult GetPTById(string id)
        {
            tbl_patientRelative tbl_patientRelative = db.tbl_patientRelative.Find(id);
            if (tbl_patientRelative == null)
            {
                return NotFound();
            }

            return Ok(tbl_patientRelative);
        }


        public IHttpActionResult GetPatientRelaiveByPatient(string pt_id)
        {
            tbl_patientRelative tbl_patientRelative = db.tbl_patientRelative.Where(x => x.pt_id == pt_id).FirstOrDefault();
            if (tbl_patientRelative == null)
            {
                return NotFound();
            }

            return Ok(tbl_patientRelative);
        }

        // PUT: api/PatientRelative/5
        [ResponseType(typeof(void))]
        public IHttpActionResult UpdatePatientRelative(string id, tbl_patientRelative tbl_patientRelative)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            if (id != tbl_patientRelative.id)
            {
                return BadRequest();
            }

            db.Entry(tbl_patientRelative).State = EntityState.Modified;

            try
            {
                db.SaveChanges();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!tbl_patientRelativeExists(id))
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

        // POST: api/PatientRelative
        [ResponseType(typeof(tbl_patientRelative))]
        public IHttpActionResult CreatePatientRelative(tbl_patientRelative tbl_patientRelative)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            db.tbl_patientRelative.Add(tbl_patientRelative);

            try
            {
                db.SaveChanges();
            }
            catch (DbUpdateException)
            {
                if (tbl_patientRelativeExists(tbl_patientRelative.id))
                {
                    return Conflict();
                }
                else
                {
                    throw;
                }
            }

            return CreatedAtRoute("DefaultApi", new { id = tbl_patientRelative.id }, tbl_patientRelative);
        }

        // DELETE: api/PatientRelative/5
        [ResponseType(typeof(tbl_patientRelative))]
        public IHttpActionResult DeletePatientRelative(string id)
        {
            tbl_patientRelative tbl_patientRelative = db.tbl_patientRelative.Find(id);
            if (tbl_patientRelative == null)
            {
                return NotFound();
            }

            db.tbl_patientRelative.Remove(tbl_patientRelative);
            db.SaveChanges();

            return Ok(tbl_patientRelative);
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }

        private bool tbl_patientRelativeExists(string id)
        {
            return db.tbl_patientRelative.Count(e => e.id == id) > 0;
        }
    }
}