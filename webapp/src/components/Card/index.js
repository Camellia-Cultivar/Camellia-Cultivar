import React from 'react'

const Card = (props) => {

    return (
        <div className={"rounded-lg " + props.className} onClick={()=>{props.redirect(`${props.camelliaId}`)}}>

            <div className=" bg-emerald-900/20 grid grid-cols-2 rounded-lg">
                <div className="m-2 lg:m-4 h-[150px] w-[150px]">
                    {props.image===null ? 
                    <img src="/logo.svg" className="aspect-square object-cover" alt="Logo"></img>
                    :
                    <img alt="" className="rounded-lg aspect-square object-cover" src={props.image}></img>}
                </div>
                <div className="m-1 text-center flex flex-col justify-center align-middle h-full">
                    <p className="text-lg sm:text-base font-bold">{props.name}</p>
                    <p className="text-sm sm:text-xs font-medium">{props.species}</p>
                </div>
            </div>
        </div>
    )
}

export default Card