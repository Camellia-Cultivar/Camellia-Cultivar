import React from 'react'

const BallDecoration = ({className}) => {
    return (
        <div className={className}>
        <div className="lg:fixed  lg:bottom-0 lg:right-0">
            <div className="h-10 w-10 bg-emerald-900 rounded-full absolute -top-12 -left-16">
            </div>
            <div className="h-10 w-10 bg-emerald-900 rounded-full absolute top-16 -left-24">
            </div>
            <div className="h-16 w-16 bg-emerald-900 rounded-full absolute bottom-20 right-32">
            </div>
            <div className="h-28 w-28 bg-emerald-900 rounded-full absolute -bottom-16 right-28">
            </div>
            <div className="h-20 w-20 bg-emerald-900 rounded-full absolute bottom-36 right-4">
            </div>
            <div className="h-40 w-40 bg-emerald-900 rounded-full relative -bottom-5 -right-16">
            </div>
        </div>

        </div>
    )
}

export default BallDecoration