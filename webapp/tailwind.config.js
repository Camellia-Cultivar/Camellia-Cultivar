let plugin = require('tailwindcss/plugin')

module.exports = {
  content: [
    "./src/**/*.{js,jsx,ts,tsx}",
  ],
  theme: {
    extend: {
      maxWidth:{
        '4/5':'80%',
      }
    }
  },
  plugins: [
      plugin(function ({ addVariant }) {
        addVariant('second', '&:nth-child(2)')
    })
  ],
}