// const axios = require('axios');
// const express = require('express');
// const { OpenAIApi } = require('openai');
// const app = express();
const {Configuration,OpenAIApi} = require("openai")

require("dotenv").config()
// const client = axios.create({
//     headers:{
//         'Authorization': 'Bearer '+ process.env.OPENAI_API_KEY
    
//     }
// });

// app.get('/',(req,res)=>{
//     runPrompt();
//     res.send('<h1>Hello this is only start</h1>')
// })
const params = {
    "prompt":"Generate a personalized travel itinerary for a trip from Patna to Delhi with a budget of 10000 rupees. ",
    "max_tokens":1024

}

const config= new Configuration({
    apiKey:"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"
})

const openai= new OpenAIApi(config)

const runPrompt= async()=>{
    const prompt ="Plan a 2 day trip from patna to delhi"


    // List of trains from patna to delhi  with arrival and departure time on monday
    // Show me a list of hotels near rajiv nagar in delhi with price in rupee
    // Plan a roadtrip from patna to delhi via agra and pryagraj
    // Plan a roadtrip from patna to delhi with shortest route
    // Plan a trip from patna to delhi for 3 days via plane
    // 
    const response = await openai.createChatCompletion({
        model:"gpt-3.5-turbo",
        max_tokens:2048,
        messages:[
            {
              "role": "user",
              "content": "Plan a trip from patna to delhi for 3 days via plane"
            }
          ]
        
    });
    console.log(response.data.choices[0].message.content);
}
runPrompt();

// client.post('https://api.openai.com/v1/engines/davinci/completions', params)
//   .then(result => {
//     console.log(result.data.choices[0].text);
//   }).catch(err => {
//     // console.log(err);
//     console.log('error')
//   });

//   app.listen(3000,console.log('Server is listening on 3000'))