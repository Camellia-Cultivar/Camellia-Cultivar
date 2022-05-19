import React from "react";
import "./index.css";

function StepList(props) {
    return (
        <div className="numbered-list-round fade-in" style={{animationDelay:`${props.baseDelay}ms`}}>
            { props.steps.map( (s, index) =>
                <p className="fade-in" key={"step-" + index} style={{animationDelay:`${props.baseDelay + index * 100 }ms`}}>
                    {s.content}
                </p>
            )}
        </div>
    );
}
export default StepList;