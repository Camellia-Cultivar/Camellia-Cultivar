import React from 'react'
import Card from '../Card'

const CardList = (props) => {
    return <>
    {props.camellias.map((camellia, index) => (<Card className="hover:scale-110 hover:shadow transition-transform duration-75 ease-linear fade-in" style={{ animationDelay: `${props.baseDelay+index*50}ms` }} key={camellia.id} image={camellia.photograph} name={camellia.epithet} species={camellia.species} redirect={props.redirect} camelliaId={camellia.id}></Card>))}
    </>

}

export default CardList