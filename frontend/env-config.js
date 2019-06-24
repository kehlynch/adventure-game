const prod = process.env.NODE_ENV === "production";

module.exports = {
  "process.env.API_HOST": prod ? process.env.API_HOST : "http://backend:4000",
  "process.env.JS_API_HOST": prod
    ? process.env.API_HOST
    : "http://localhost:4009",
  "process.env.MIXPANEL_API_KEY": prod
    ? process.env.MIXPANEL_API_KEY
    : "04929fee853d426ef22b383c31a01644", // Insert dev MIXPANEL_API_KEY here
  "process.env.NODE_ENV": process.env.NODE_ENV
};
