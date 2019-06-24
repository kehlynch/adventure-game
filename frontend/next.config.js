module.exports = {
  webpack: (config, { dev }) => {
    // Perform customizations to config
    config.module.rules = config.module.rules.map(rule => {
      // Disable babel-loader caching
      // This means changes in env-config.js will not require a cache clear
      if (rule.loader === "babel-loader") {
        rule.options.cacheDirectory = false;
      }
      return rule;
    });

    const oldEntry = config.entry;
    config.entry = () => {
      return oldEntry().then(entries => {
        entries["main.js"].unshift("./lib/polyfill");
        return entries;
      });
    };

    return config;
  }
};
