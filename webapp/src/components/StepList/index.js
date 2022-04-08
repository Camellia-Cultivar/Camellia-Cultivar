import React from "react";
import Step from "../Step";

function StepList(props) {
    return (
        <div>
            { props.steps.map( s => <Step id={s.id} content={s.content} />)}
        </div>
    );
}

export default StepList;