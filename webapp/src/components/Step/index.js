import React from "react";


function Step(props) {
    return (
        <div className="flex gap-3 items-center text-lg my-6">
            <div className="flex justify-center items-center font-medium text-neutral-900 dark:text-white bg-teal-400 rounded-full aspect-square w-8">
                {props.id}
            </div>
            <div>
                {props.content}
            </div>
        </div>
    );
}

export default Step;