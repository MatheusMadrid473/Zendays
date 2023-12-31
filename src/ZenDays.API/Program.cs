using AutoMapper;
using FirebaseAdmin;
using Google.Apis.Auth.OAuth2;
using ZenDays.API.Configurations;
using ZenDays.API.Middlewares;
using ZenDays.IOC;
using ZenDays.Service.DTO.Config;

var builder = WebApplication.CreateBuilder(args);

// Configuration setup
var configuration = new ConfigurationBuilder()
    .SetBasePath(builder.Environment.ContentRootPath)
    .AddJsonFile("appsettings.json", optional: false, reloadOnChange: true)
    .Build();

FirebaseApp.Create(new AppOptions()
{
    Credential = GoogleCredential.FromFile(configuration["FirestoreConfig:JsonFilePath"]),
});
// Add services to the container.

builder.Services.InjectDependencies();
#region AutoMapper
var mapConfig = new MapperConfiguration(cfg =>
{
    cfg.AddProfile(new AutoMapperProfile());
});
IMapper mapper = mapConfig.CreateMapper();
builder.Services.AddSingleton(mapper);
#endregion

#region JWT
builder.Services.AddAuthenticationConfiguration(builder.Configuration);
builder.Services.AddAuthorizationConfiguration();
builder.Services.AddSwaggerConfiguration();
#endregion
builder.Services.AddControllers();
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

builder.Services.AddCors(options =>
{
    options.AddPolicy("*", build => build.AllowAnyHeader().AllowAnyMethod().AllowAnyOrigin());
});

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}


app.UseRouting();
app.UseCors("*");
app.UseAuthentication();
app.UseAuthorization();
app.UseHttpsRedirection();
app.UseMiddleware<JwtMiddleware>();
app.UseMiddleware(typeof(HandlingMiddleware));



app.MapControllers();

app.Run();
