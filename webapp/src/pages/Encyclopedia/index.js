import React, {useState} from 'react'
import { AiOutlineSearch } from "react-icons/ai";

import Card from "../../components/Card"

import camellias from "./camellias"

const Encyclopedia = () => {

    let [page, setPage] = useState(1)


    const pages = 9;

    let buttons = []
    let classN = "";
    for (let index = 0; index < pages; index++) {
        page===index+1 ? classN="bg-white":classN="bg-stone-100";
        
        if (index === 0)
            classN += " px-4 border-2 rounded-l-lg text-lg"
        else if (index === pages - 1)
            classN += " px-4 border-2 rounded-r-lg text-lg"
        else
            classN += " px-4 border-2 text-lg"


        if (index < 4 || index + 1 === pages) {
            buttons.push(<button onClick={()=> {setPage(index+1)}} className={classN+" active:scale-95"}>{index + 1}</button>)
        } else if (index === 4) {
            buttons.push(<button className={classN}>...</button>)
        }

    }

    return (
        <div className="container-4/5 flex flex-col">
            <div className="pt-16 pb-6 ml-4">
                <p className="text-3xl font-bold text-center md:text-start">Encyclopedia</p>
            </div>
            <div className="self-center flex flex-col w-full pt-4">
                <div className="flex w-full ">
                    <input placeholder="Search for a cultivar" className=" rounded-3xl border-2 px-3 py-2 shadow w-11/12 mr-2 md:mr-4 sm:text-base md:text-xl h-full focus:border-emerald-900"></input>
                    <button className="bg-emerald-900 text-white text-2xl px-4 md:px-6 py-1 rounded-3xl active:scale-110 hover:scale-105"><AiOutlineSearch></AiOutlineSearch></button>
                </div>
                <div className=" flex md:justify-start mt-4">
                    <button className="bg-emerald-900 text-white font-light text-base md:text-lg px-4 md:px-6 py-1 mx-1 md:mx-4 rounded-3xl active:scale-110 hover:scale-105">Filter By</button>
                    <button className="bg-emerald-900 text-white font-light text-base md:text-lg px-4 md:px-6 py-1 mx-1 md:mx-4 rounded-3xl active:scale-110 hover:scale-105">Sort By</button>
                </div>
            </div>
            <div className="grid sm:grid-cols-2 sm:gap-x-4 md:grid-cols-3 md:grid-rows-3 md:gap-x-8 gap-y-10 mt-10">
                {
                    camellias.map((camellia) => {
                        return (
                            <Card className="hover:scale-110 hover:shadow" key={camellia.id} image={camellia.image} name={camellia.name} species={camellia.species}></Card>
                        )
                    })
                }
            </div>
            <div className="mt-8 mb-4 flex justify-center">
                {buttons.map((button) => { return (button) })}
            </div>

        </div>
    )
}

export default Encyclopedia