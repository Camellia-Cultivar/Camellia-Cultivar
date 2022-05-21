import {useState, useEffect} from 'react'

const useIntersection = (element, rootMargin) => {

    const [isVisible, setIsVisible] = useState(false);

    useEffect(()=>{
        const observer = new IntersectionObserver(
            ([entry]) => {
                if(entry.isIntersecting){
                    setIsVisible(entry.isIntersecting);
                    observer.unobserve(element.current);
                }
            },{
                rootMargin
            }
        );
        element.current && observer.observe(element.current);

        return ()=>{
            observer.unobserve(element.current);
        }
    }, [element, rootMargin]);


  return isVisible;
}

export default useIntersection