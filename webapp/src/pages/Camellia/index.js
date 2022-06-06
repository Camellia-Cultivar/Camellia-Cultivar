import React, { useState, useEffect } from 'react'
import { useParams } from 'react-router-dom'
import CamelliaCategory from '../../components/CamelliaCategory';
import { BiImages } from "react-icons/bi";
import axios from 'axios';

import CharacteristicDropdown from '../../components/CharacteristicDropdown';
import AnimateHeight from 'react-animate-height';
const Camellia = () => {


    const [camellia, setCamellia] = useState({});
    const [moreLoaded, setMoreLoaded] = useState(false);
    const [height, setHeight] = useState(0);
    const [fetched, setFetched] = useState(false);



    const params = useParams()


    useEffect(() => {
        if (!fetched) {
            axios.get(`/api/public/cultivars/${params.id}`)
                .then((response) => {
                    console.log(response);
                    setCamellia(response.data)
                    setFetched(true);
                })
                .catch((err) => {
                    console.error(err)
                })

        }
    })

    const loadMore = () => {
        height === 'auto' ? setTimeout(() => { setMoreLoaded(!moreLoaded) }, 305) : setMoreLoaded(!moreLoaded);
        setHeight(
            height === 0 ? 'auto' : 0
        )
    }


    return (
        <div className="mt-8 sm:mt-16 mb-8 mx-4 sm:container-4/5 flex flex-col md:flex-row justify-between">
            <div className="grid auto-rows-min md:w-1/2">
                <div >
                    <p className="text-5xl font-semibold text-emerald-900">
                        {camellia.epithet}
                    </p>
                </div>
                <div className="mt-8 w-full bg-emerald-900/5 rounded-lg p-4">
                    <p className="font-bold text-3xl text-emerald-900 mb-6">Description</p>
                    <p className="text-emerald-900 text-justify">
                        {camellia.description}
                    </p>
                </div>
                <div className="mt-8 w-full bg-emerald-900/5 rounded-lg p-4">
                    <p className="font-bold text-3xl text-emerald-900 mb-6">Characteristics</p>
                    {/* <CharacteristicDropdown characteristic="Plant" down={false} details={camellia.plant}></CharacteristicDropdown>
                    <CharacteristicDropdown characteristic="Size" down={false} details={camellia.size}></CharacteristicDropdown>
                    <CharacteristicDropdown characteristic="Flower" down={false} details={camellia.flower}></CharacteristicDropdown>
                    <CharacteristicDropdown characteristic="Folliage" down={false} details={camellia.folliage}></CharacteristicDropdown> */}
                </div>
            </div>
            <div className="md:w-1/3 mt-8 md:mt-0">
                <div className="flex flex-col">
                    <img className="shadow-md self-center w-11/12 rounded-lg object-cover" src={camellia.photograph} alt={camellia.epithet}></img>
                    <CamelliaCategory description={camellia.species} category="Species / Combination" />
                    <CamelliaCategory description={`${camellia.species} '${camellia.epithet}'`} category="Scientific Name" />
                    <div className="bg-emerald-900/20 mt-8 rounded-full flex items-center justify-center py-4 text-emerald-900 cursor-pointer hover:scale-105" onClick={() => { loadMore() }}>
                        <BiImages></BiImages>
                        <p className="ml-2 text-center text-emerald-900">{moreLoaded ? "Less Photos" : "More Photos"}</p>
                    </div>
                    {/* <AnimateHeight duration={500} height={height}>
                        {moreLoaded &&
                            <div className="grid gap-y-3 gap-x-2 md:gap-x-1 grid-cols-2 md:grid-cols-3 mt-8">
                                {camellia.otherImages.map((image) => {
                                    return (
                                        <div className="flex justify-center">
                                            <img className="max-h-40 object-cover rounded-md shadow" alt="" src={image}></img>
                                        </div>)
                                })}
                            </div>
                        }
                    </AnimateHeight> */}

                </div>
            </div>

        </div>
    )

}

export default Camellia;
