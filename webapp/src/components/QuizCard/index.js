import React from "react";
import './index.css';

function QuizCard(prop) {

    // return (
    //     <div className="md:scroll-mx-6 md:gap-2 snap-center snap-mandatory grid justify-items-stretch rounded-lg bg-emerald-900/10 min-w-max md:min-w-[75%] md:max-w-md lg:max-w-lg px-2 pt-2 pb-6 select-none pop-in" style={{animationDelay:`${prop.delay}ms`}}>
    //         <div className="grid grid-cols-4 grid-rows-3 gap-0.5 md:gap-1.5">
    //             { prop.images.slice(0, 4).map((link, index) =>
    if (prop.images.length >= 1) {
        const maxInd = Math.min(prop.images.length, 4)

        let photoGrid;

        if (maxInd <= 1) {
            photoGrid =
                <div
                    className={"flex flex-row items-stretch"}
                >
                    <div
                        className={
                            "grow rounded-md cursor-pointer gap-1 last:text-lg xl:last:text-3xl text-xl last:font-semibold text-transparent bg-no-repeat bg-center bg-cover ring-4 ring-transparent hover:ring-teal-300 focus:ring-teal-300"}
                        style={{backgroundImage: `url(${prop.images[0]})`}}
                    ></div>
                </div>;
        }
        else {
            let basisClass;

            // switch needed because dynamic construction of class names does not work
            switch (maxInd) {
                case 4:
                    basisClass = "basis-3/4"
                    break
                case 3:
                    basisClass = "basis-7/12"
                    break
                default:
                    basisClass = "basis-1/2"
            }
            photoGrid =
                <div className={"flex flex-row items-stretch gap-1"}>
                    <div
                        className={
                            (basisClass + " rounded-l-md") +
                            " cursor-pointer gap-1 last:text-lg xl:last:text-3xl text-xl last:font-semibold text-transparent bg-no-repeat bg-center bg-cover ring-4 ring-transparent hover:ring-teal-300 focus:ring-teal-300"}
                        style={{backgroundImage: `url(${prop.images[0]})`}}
                    ></div>
                    <div className="grow grid grid-flow-row auto-rows-fr items-stretch justify-items-stretch gap-1">
                        { prop.images.slice(1, maxInd).map((link, index, row) =>
                            <div
                                key={prop.id + "-image-" + index}
                                className="relative cursor-pointer row-span-1 col-span-1
                                    first:rounded-tr-md last:rounded-br-md
                                    last:text-lg xl:last:text-3xl text-xl last:font-semibold text-transparent
                                    bg-no-repeat bg-center bg-cover
                                    ring-4 ring-transparent hover:ring-teal-300 focus:ring-teal-300"
                                style={{backgroundImage: `url(${link})`}}
                            >{(index + 1 === row.length) && row.length < prop.images.length - 1 && (
                                <p>+{(prop.images.length - index)}</p>
                            )}</div>
                        )}
                    </div>
                </div>;
        }


        return (
            <div className={'quiz-card bg-emerald-900/10 snap-center pop-in'} style={{animationDelay:`${prop.delay}ms`}}>
                {photoGrid}
                <div className="justify-self-center relative mt-3.5 w-3/4 group">
                    <input id={"cultivar_input_" + prop.id} className="block py-2 px-0 w-full text-sm text-gray-900 bg-transparent border-0 border-b-2 border-gray-300 appearance-none outline-none ring-0 focus:border-emerald-900 peer" placeholder=" " type="text"/>
                    <label htmlFor={"cultivar_input_" + prop.id} className="cursor-text peer-focus:cursor-auto absolute text-sm text-gray-500 font-medium duration-300 scale-75 -translate-y-5 transform top-2.5 origin-[0] peer-focus:text-emerald-900 peer-placeholder-shown:scale-100 peer-placeholder-shown:translate-y-0 peer-focus:scale-75 peer-focus:-translate-y-5">Name the Cultivar</label>
                </div>
            </div>
        );
    }
}


export default QuizCard;