import React from 'react'

const Sugestion = (props) => {
  return (
    <div onClick={()=>{props.onClick(props.cultivar)}} className="flex md:text-xl text-base py-2 cursor-pointer px-4 hover:bg-slate-50">
      <p className="px-2">{props.cultivar.denomination}</p>
    </div>
  )
}

export default Sugestion