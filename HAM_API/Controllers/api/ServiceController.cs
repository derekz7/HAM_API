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
    public class ServiceController : ApiController
    {
        private hapdbEntities db = new hapdbEntities();


        [HttpGet]
        public IQueryable<tbl_service> GetAllServices()
        {
            return db.tbl_service;
        }


        [HttpGet]
        [ResponseType(typeof(tbl_service))]
        public IHttpActionResult GetServiceById(string id)
        {
            tbl_service tbl_service = db.tbl_service.Find(id);
            if (tbl_service == null)
            {
                return NotFound();
            }

            return Ok(tbl_service);
        }

        [HttpPut]
        [ResponseType(typeof(void))]
        public IHttpActionResult UpdateService(string id, tbl_service service)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            if (id != service.id)
            {
                return BadRequest();
            }

            db.Entry(service).State = EntityState.Modified;

            try
            {
                db.SaveChanges();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!tbl_serviceExists(id))
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


        [HttpPost]
        [ResponseType(typeof(tbl_service))]
        public IHttpActionResult CreateService(tbl_service service)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            db.tbl_service.Add(service);

            try
            {
                db.SaveChanges();
            }
            catch (DbUpdateException)
            {
                if (tbl_serviceExists(service.id))
                {
                    return Conflict();
                }
                else
                {
                    throw;
                }
            }

            return CreatedAtRoute("DefaultApi", new { id = service.id }, service);
        }


        [HttpDelete]
        [ResponseType(typeof(tbl_service))]
        public IHttpActionResult DeleteService(string id)
        {
            tbl_service tbl_service = db.tbl_service.Where(x => x.id == id).FirstOrDefault();
            if (tbl_service == null)
            {
                return NotFound();
            }

            db.tbl_service.Remove(tbl_service);
            db.SaveChanges();

            return Ok(tbl_service);
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }

        private bool tbl_serviceExists(string id)
        {
            return db.tbl_service.Count(e => e.id == id) > 0;
        }
    }
}