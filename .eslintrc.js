module.exports = {
  'env': {
    'browser': true,
    'es2021': true,
  },
  'extends': [
    'google',
  ],
  'parserOptions': {
    'ecmaVersion': 12,
    'sourceType': 'module',
  },
  'rules': {
    "indent": ["error", 2],
    "require-jsdoc": 0,
    "eqeqeq": ["error", "always"]
  },
};
