export const signIn = () =>{
    return {
        type: 'SIGN_IN'
    }
}

export const signOut = () =>{
    return {
        type: 'SIGN_OUT'
    }
}

export const signedOut = () =>{
    return {
        type: 'SIGNED_OUT'
    }
}

export const signedIn = (user) =>{
    return {
        type: 'SIGNED_IN',
        payload: user
    }
}

export const setMod = () =>{
    return {
        type: 'IS_MOD'
    }
}

export const setNotMod = () =>{
    return {
        type: 'IS_NOT_MOD'
    }
}
