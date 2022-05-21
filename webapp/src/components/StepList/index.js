import React from "react";
import Step from "../Step";

function StepList(props) {
    return (
        <div>
            { props.steps.map( s => <Step key={s.id} baseDelay={props.baseDelay} id={s.id} content={s.content} />)}
        </div>
    );
}

export default StepList;