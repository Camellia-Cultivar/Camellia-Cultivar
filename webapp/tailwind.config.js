let plugin = require('tailwindcss/plugin')

module.exports = {
  content: [
    "./src/**/*.{js,jsx,ts,tsx}",
  ],
  theme: {
    extend: {
      maxWidth:{
        '1/5':'20%',
        '2/5':'40%',
        '3/5':'60%',
        '4/5':'80%',
      }
      
    },

  },
  plugins: [
      plugin(function ({ addVariant }) {
        addVariant('second', '&:nth-child(2)')
    })
  ],
}