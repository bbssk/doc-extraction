const cds = require("@sap/cds");
const { Readable, PassThrough } = require("stream");
//const extDocument = require("./external/documentinformationextractionapi")
const fs = require('fs');
const path = require('path');

module.exports = cds.service.impl(async function () {
    const { MediaFile } = this.entities;
    var extservice = await cds.connect.to("Document.Information.Extraction");
    this.before("CREATE", MediaFile, async (req, next) => {

        const filePath = path.join(__dirname, "invoice.pdf");
        const fileBuffer = fs.readFileSync(filePath);
        const binaryData = new Uint8Array(fileBuffer);
        // const binaryString = Array.from(new Uint8Array(binaryData))
        //     .map(byte => String.fromCharCode(byte))
        //     .join('');
        var file = {
            "file": Buffer.from(binaryData)
        };

        //var result = await extservice.send("document_jobs_post", file);

        var result = await extservice.send("document_jobs_post", file);
        console.log(result);

    });
});


// const cds = require("@sap/cds");

// class mediaSRV extends cds.ApplicationService {
//   async init() {
//     const { MediaFile } = this.entities;

//     this.on("getCurrentWeather", MediaFile, async (req) => {
//       const sites = await req.query;
//       if (!sites.length) {
//         return req.reject(404);
//       }

//       const { postalCode, country_code: country } = sites[0].postalAddress;
//       const weatherSrv = await cds.connect.to("OpenWeatherMap.API");
//       const weatherData = await weatherSrv.send("weather", {
//         q: null,
//         id: null,
//         lat: null,
//         lon: null,
//         zip: `${postalCode},${country}`,
//         units: "metric",
//         lang: "en",
//         mode: "json",
//       });

//       return {
//         condition: weatherData.weather[0]?.description ?? null,
//         temparature: weatherData.main.temp,
//         humidity: weatherData.main.humidity,
//         windspeed: weatherData.wind.speed,
//       };
//     });

//     await super.init();
//   }
// }

// module.exports = mediaSRV;