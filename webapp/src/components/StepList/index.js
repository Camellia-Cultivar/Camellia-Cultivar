import React from "react";
import "./index.css";

function StepList(props) {
    return (
        <div className="numbered-list-round">
            { props.steps.map( s =>
                <p className="">
                    {s.content}
                </p>
            )}
        </div>
    );
}
export default StepList;