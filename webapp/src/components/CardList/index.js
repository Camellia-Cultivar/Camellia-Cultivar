import React from 'react'
import Card from '../Card'

const CardList = (props) => {
    return <>
    {props.camellias.map((camellia) => (<Card className="hover:scale-110 hover:shadow transition-transform duration-75 ease-linear" key={camellia.id} image={camellia.photograph} name={camellia.epithet} species={camellia.species} redirect={props.redirect} camelliaId={camellia.id}></Card>))}
    </>

}

export default CardList