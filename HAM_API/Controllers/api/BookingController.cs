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
    public class BookingController : ApiController
    {
        private DBContext db = new DBContext();

        // GET: api/Booking
        public IQueryable<tbl_booking> GetBookingList()
        {
            return db.tbl_booking;
        }

        // GET: api/Booking/5
        [ResponseType(typeof(tbl_booking))]
        public IHttpActionResult GetBookingById(string id)
        {
            tbl_booking tbl_booking = db.tbl_booking.Find(id);
            if (tbl_booking == null)
            {
                return NotFound();
            }

            return Ok(tbl_booking);
        }

        // PUT: api/Booking/5
        [ResponseType(typeof(void))]
        public IHttpActionResult BookingUpdate(string id, tbl_booking tbl_booking)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            if (id != tbl_booking.id)
            {
                return BadRequest();
            }

            db.Entry(tbl_booking).State = EntityState.Modified;

            try
            {
                db.SaveChanges();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!tbl_bookingExists(id))
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


        [ResponseType(typeof(void))]
        public IHttpActionResult ChangeStatus(string id, string status)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }
            tbl_booking booking = db.tbl_booking.Find(id) as tbl_booking;
            if (booking == null)
            {
                return BadRequest();
            }
            booking.status = status;

            db.Entry(booking).State = EntityState.Modified;

            try
            {
                db.SaveChanges();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!tbl_bookingExists(id))
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



        // POST: api/Booking
        [ResponseType(typeof(tbl_booking))]
        public IHttpActionResult Create(tbl_booking tbl_booking)
        {
            tbl_booking.status = "Pending";
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            db.tbl_booking.Add(tbl_booking);

            try
            {
                db.SaveChanges();
            }
            catch (DbUpdateException)
            {
                if (tbl_bookingExists(tbl_booking.id))
                {
                    return Conflict();
                }
                else
                {
                    throw;
                }
            }

            return CreatedAtRoute("DefaultApi", new { id = tbl_booking.id }, tbl_booking);
        }

        // DELETE: api/Booking/5
        [ResponseType(typeof(tbl_booking))]
        public IHttpActionResult Delete(string id)
        {
            tbl_booking tbl_booking = db.tbl_booking.Find(id);
            if (tbl_booking == null)
            {
                return NotFound();
            }

            db.tbl_booking.Remove(tbl_booking);
            db.SaveChanges();

            return Ok(tbl_booking);
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }

        private bool tbl_bookingExists(string id)
        {
            return db.tbl_booking.Count(e => e.id == id) > 0;
        }
    }
}