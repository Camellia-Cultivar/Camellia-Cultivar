import React, { useState, useEffect } from 'react'
import { useNavigate } from 'react-router-dom';
import { IoSearch, IoCloseCircleOutline } from "react-icons/io5";
import { AiOutlineLoading3Quarters } from 'react-icons/ai'
import axios from 'axios'

import Card from "../../components/Card"
import Sugestion from "../../components/Sugestion"

// import camellias from "./camellias"

const Encyclopedia = () => {

    const navigate = useNavigate();
    const [page, setPage] = useState(1);
    const [camellias, setCamellias] = useState({});
    const [fetched, setFetched] = useState(false);
    const [searchText, setSearchText] = useState("");
    const [sugestionsOn, setSugestionsOn] = useState(false);
    const [autocompletedCamellias, setAutocompletedCamellias] = useState([]); //
    const [sugestion, setSugestion] = useState({});
    const [chosenSugestion, setChosenSugestion] = useState(false);
    const [isLoading, setIsLoading] = useState(false);



    useEffect(() => {
        fetchPage();
    })


    const fetchPage = () => {
        if (!fetched){
            axios.get('/api/public/cultivars', { params: { page: page } })
                .then((response) => {
                    setCamellias(response.data)
                    setFetched(true)
                })
                .catch((error) => {
                    console.log(error)
                })
        }
    }


    const getAutocompleteOnChange = (e) => {
        setSearchText(e.target.value)
        if (e.target.value.length > 2) {
            setSugestionsOn(true)
            axios.get('/api/public/autocomplete', { params: { substring: e.target.value } })
                .then((response) => {
                    setAutocompletedCamellias(response.data)
                })
                .catch((error) => {
                    console.log(error)
                })
        }
        else {
            setSugestionsOn(false)
        }
    }



    const setSugestionClicked = (sugestion) => {
        setSearchText(sugestion.denomination);
        setSugestionsOn(false);
        setChosenSugestion(true);
        setSugestion(sugestion)
        axios.get(`/api/public/cultivars/${sugestion.cultivarId}`)
            .then((response) => {
                setCamellias([response.data])
            })
            .catch((error) => {
                console.log(error)
            })
    }



    const clearAll = () => {
        axios.get('/api/public/cultivars', { params: { page: page } })
            .then((response) => {
                setCamellias(response.data)
                setFetched(true)
                setSearchText("")
                setChosenSugestion(false)
                setSugestionsOn(false)
            })
            .catch((error) => {
                console.log(error)
            })

    }

    const searchCultivar = async () => {
        let tempCamellias = [];
        if (searchText === "") {
            clearAll();
            return;
        };
        await axios.get('/api/public/autocomplete', { params: { substring: searchText } })
            .then((response) => {
                response.data.map((data, index) => {
                    axios.get(`/api/public/cultivars/${data.cultivarId}`)
                        .then((newResponse) => {
                            tempCamellias.push(newResponse.data)
                        })
                        .catch((error) => {
                            console.log(error)
                        })
                    return null;
                })

            })
            .finally(() => {
                setIsLoading(true);
                setSugestionsOn(false);
                setChosenSugestion(true);
                setTimeout(() => {
                    setCamellias(tempCamellias);
                    setIsLoading(false);
                }, 500)
                setCamellias(tempCamellias);
            })
            .catch((error) => {
                console.log(error)
            })




    }

    const changePage = (index) => {
        setFetched(false); 
        setPage(index + 1);

        
    }



    const pages = 1001;

    let buttons = []
    let classN = "";
    for (let index = 0; index < pages; index++) {
        page === index + 1 ? classN = "bg-white" : classN = "bg-stone-100";

        if (index === 0)
            classN += " px-4 border-2 rounded-l-lg text-lg"
        else if (index === pages - 1)
            classN += " px-4 border-2 rounded-r-lg text-lg"
        else
            classN += " px-4 border-2 text-lg"


        if (index < 4 || index + 1 === pages) {
            buttons.push(<button key={index} onClick={() => { changePage(index)}} className={classN + " active:scale-95"}>{index + 1}</button>)
        } else if (index === 4) {
            buttons.push(<button key={index} className={classN}>...</button>)
        }

    }

    const redirect = (route) => {
        navigate(route);
    }



    return (
        <div className="container-4/5 mt-16 mb-8 flex flex-col">
            <div className="pb-6 ml-4">
                <p className="text-3xl font-bold text-center md:text-start">Encyclopedia</p>
            </div>
            <div className="self-center flex flex-col w-full pt-4">
                <div className="flex w-full relative">

                    <div className=" flex w-11/12 mr-2 md:mr-4 relative sm:text-base md:text-xl">
                        {sugestionsOn &&
                            <div className=" w-full top-[50%] pt-8 pb-2 rounded-b-xl absolute bg-white shadow-md">
                                {autocompletedCamellias.map((ac, index) => (
                                    <Sugestion onClick={(search) => setSugestionClicked(search)} key={index} cultivar={ac} />
                                ))}
                            </div>
                        }
                        <input
                            value={searchText}
                            onChange={(e) => { getAutocompleteOnChange(e) }}
                            placeholder="Search for a cultivar"
                            className={`z-[1] rounded-3xl border-2 px-4 py-2 shadow w-full h-full outline-none ${sugestionsOn && `shadow-none border-x-0 border-b-0`}`}
                        >
                        </input>
                        {searchText !== "" && <IoCloseCircleOutline onClick={() => { clearAll() }} className="absolute z-[2] top-[30%] right-4 text-emerald-900"></IoCloseCircleOutline>}
                    </div>
                    <button onClick={() => { searchCultivar() }} className="bg-emerald-900 text-white text-2xl px-4 md:px-6 py-1 rounded-3xl active:scale-95 hover:scale-105"><IoSearch></IoSearch></button>
                </div>
                <div className=" flex md:justify-start mt-4">
                    <button className="bg-emerald-900 text-white font-light text-base md:text-lg px-4 md:px-6 py-1 mx-1 md:mx-4 rounded-3xl active:scale-95">Filter By</button>
                    <button className="bg-emerald-900 text-white font-light text-base md:text-lg px-4 md:px-6 py-1 mx-1 md:mx-4 rounded-3xl active:scale-95">Sort By</button>
                </div>
            </div>

            {isLoading ?


                <div className="my-28 flex justify-center">
                    <AiOutlineLoading3Quarters className="loading text-emerald-900 text-4xl"></AiOutlineLoading3Quarters>
                </div>

                :
                <div className="grid sm:grid-cols-2 sm:gap-x-4 md:grid-cols-3 md:grid-rows-3 md:gap-x-8 gap-y-10 mt-10">
                    {chosenSugestion ?
                        camellias.map((camellia) => (<Card className="hover:scale-110 hover:shadow transition-transform duration-75 ease-linear" key={camellia.id} image={camellia.photograph} name={camellia.epithet} species={camellia.species} redirect={redirect} camelliaId={camellia.cultivar_id}></Card>))

                        :
                        Object.entries(camellias).map((camellia) => {
                            return (
                                <Card className="hover:scale-110 hover:shadow transition-transform duration-75 ease-linear" key={camellia[1].id} image={camellia[1].photograph} name={camellia[1].epithet} species={camellia[1].species} redirect={redirect} camelliaId={camellia[1].cultivar_id}></Card>
                            )
                        })
                    }
                </div>}
            {!chosenSugestion &&
                <div className="mt-8 mb-4 flex justify-center">
                    {buttons.map((button) => { return (button) })}
                </div>
            }

        </div>
    )
}

export default Encyclopedia