import React from "react";


function Step(props) {

    const delay = props.baseDelay + props.id*100;
    return (
        <div className={"flex gap-3 items-center text-lg my-6 fade-in"} style={{animationDelay:`${delay}ms`}}>
            <div className="flex flex-none justify-center items-center font-medium text-neutral-900 dark:text-white bg-teal-400 rounded-full aspect-square w-8">
                {props.id}
            </div>
            <div className="text-base md:text-lg">
                {props.content}
            </div>
        </div>
    );
}

export default Step;