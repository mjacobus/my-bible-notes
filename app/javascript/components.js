function importAll(r) {
  r.keys().forEach(r);
}

importAll(require.context("../components", true, /[_\/]component\.js$/));

// Components inside app/javascript/src/components/
importAll(require.context("./src/components", true, /[_\/]component\.js$/));
