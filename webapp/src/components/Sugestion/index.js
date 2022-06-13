import React from 'react'

const Sugestion = (props) => {
  return (
    <div onClick={()=>{props.setSugestionClicked(props.cultivar)}} className={props.className}>
      <p className="px-2">{props.cultivar.denomination}</p>
    </div>
  )
}

export default Sugestion