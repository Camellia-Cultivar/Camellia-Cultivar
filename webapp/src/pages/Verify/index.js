import React, {useEffect} from 'react'
import { useNavigate } from 'react-router-dom'
import axios from 'axios'


const Verify = () => {
    const navigate = useNavigate();
    useEffect(() => {
        const loggedInUser = localStorage.getItem("userToken");
        if (loggedInUser) {
            const user = JSON.parse(localStorage.getItem("userToken"));
            if (user.expiry > Date.now()) {
                axios.get(`/api/users/${user.userId}`, {
                    headers: {
                        "Authorization": `Bearer ${user.loginToken}`,
                    }
                })
                    .then(function (response) {
                        if(response.data.verified){
                            navigate("/");
                        }
                    })
                    .catch(function (error) {
                        console.log(error);
                    });
            } else {
                localStorage.removeItem("userToken");
            }

        }

    });
  return (
    <div className="absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2">
        <p className="text-3xl text-emerald-900 font-medium">Please go to your email, <span className="font-bold">verify your account</span>, and refresh this page!</p>
    </div>
  )
}

export default Verify