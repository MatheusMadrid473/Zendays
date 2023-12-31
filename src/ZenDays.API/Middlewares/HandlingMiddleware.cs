﻿using Newtonsoft.Json;
using System.Net;

namespace ZenDays.API.Middlewares
{
    public class HandlingMiddleware
    {
        private readonly RequestDelegate next;
        private readonly ILogger<HandlingMiddleware> logger;

        public HandlingMiddleware(RequestDelegate next, ILogger<HandlingMiddleware> logger)
        {
            this.next = next;
            this.logger = logger;
        }

        public async Task Invoke(HttpContext context)
        {
            try
            {
                await RequestLogAsync(context);
                await next(context);
            }
            catch (Exception ex)
            {
                await HandleExceptionAsync(context, ex);
                ErrorLog(ex);
            }
        }

        private async Task RequestLogAsync(HttpContext context)
        {
            context.Request.EnableBuffering();
            var jsonBody = await new StreamReader(context.Request.Body).ReadToEndAsync();
            var queryString = context.Request.QueryString.HasValue ? context.Request.QueryString.Value : "";
            context.Request.Body.Position = 0;

            var message = $"Type: Request - " +
                              $"Verb: {context.Request.Method} - " +
                              $"Api: {context.Request.Path} - " +
                              $"Json: {jsonBody} - " +
                              $"QueryString: {queryString}";
            logger.LogTrace(message);
        }

        private static Task HandleExceptionAsync(HttpContext context, Exception exception)
        {
            var code = HttpStatusCode.BadRequest;
            var result = exception.Message;
            var jsonError = JsonConvert.SerializeObject(result);
            context.Response.ContentType = "application/json";
            context.Response.StatusCode = (int)code;
            return context.Response.WriteAsync(jsonError);
        }

        private void ErrorLog(Exception ex)
        {
            var message = $"Type: Error - Class: {ex.GetType().ToString()}";
            logger.LogError(ex, message);
        }
    }
}

