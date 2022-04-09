import React from "react";

function QuizCard(prop) {
    return (
        <div className="grid justify-items-stretch gap-3 rounded-lg bg-emerald-900/10 max-w-lg px-2 pt-2 pb-8 select-none">
            <div className="grid grid-cols-4 grid-rows-3 gap-2">
                { prop.images.slice(0, 4).map((link, index) =>
                    <div
                        key={prop.id + "-image-" + index}
                        className="cursor-pointer text-transparent last:flex last:justify-center last:items-center last:text-white last:text-3xl last:font-semibold bg-no-repeat bg-center bg-cover bg-emerald-900 aspect-square first:col-span-3 first:row-span-3 col-span-1 row-span-1 first:rounded-l-lg second:rounded-tr-lg last:rounded-br-lg hover:ring-4 ring-teal-300 last:bg-blend-overlay"
                        style={{backgroundImage: `url(${link})`}}
                    >{"+" + (prop.images.length - index)}</div>
                )}
            </div>
            <div className="justify-self-center relative z-0 mt-3.5 w-3/4 group">
                <input id={"cultivar_input_" + prop.id} className="block py-2.5 px-0 w-full text-sm text-gray-900 bg-transparent border-0 border-b-2 border-gray-300 appearance-none outline-none ring-0 focus:border-emerald-900 peer" placeholder=" " type="text"/>
                <label htmlFor={"cultivar_input_" + prop.id} className="absolute text-sm text-gray-500 font-medium duration-300 scale-75 -translate-y-5 transform top-2.5 origin-[0] peer-focus:text-emerald-900 peer-placeholder-shown:scale-100 peer-placeholder-shown:translate-y-0 peer-focus:scale-75 peer-focus:-translate-y-5">Name the Cultivar</label>
            </div>
        </div>
    );
}

export default QuizCard;