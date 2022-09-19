import React, { useState, useEffect } from "react"
import { Typography, Box, TextField, Button } from '@mui/material';
import { styled } from '@mui/material/styles';
import { spacing } from "@mui/system";

const CustomButton = styled(Button)(spacing);

const Home = () => {
  const [tweets, setTweets] = useState([]);
  const [post, setPost] = useState(null);

  useEffect(() => {
    loadTweets();
  }, []);

  const loadTweets = async () => {
    try {
      const response = await fetch('/tweets.json');
      const json = await response.json();
      setTweets(json);
    } catch(error) {
      throw error;
      console.log(error);
    };
  };

  const handleChange = (event) => {
    setPost(event.target.value);
  };

  const handleSubmit = async () => {
    try {
      const token = document.querySelector('meta[name="csrf-token"]').content;
      const body = JSON.stringify({
        'tweet': {
          'content': post
        }
      })
      await fetch('/tweets', {
        method: 'post',
        headers: {
          "X-CSRF-Token": token,
          'Content-Type':'application/json'
        },
        body: body
      });
      await loadTweets();
    } catch(error) {
      throw error;
      console.log(error);
    };
  };

  return (
    <Box textAlign="center" spacing={2}>
      <Typography variant="h1">Twitter Copy</Typography>
      <Typography variant="h2" mt={3} mb={3}>Feed</Typography>
      <TextField variant='outlined' placeholder="What's up?" onChange={handleChange} />
      <CustomButton variant='contained' onClick={handleSubmit} ml={2} mt={1}>Tweet</CustomButton>
      {
        tweets.map((tweet) => {
          return(
            <Box m={5}>
              <Typography><b>{tweet.email}</b> tweeted on: {tweet.created_at}</Typography>
              <Typography variant="h6">{tweet.content}</Typography>
            </Box>
          );
        })
      }
    </Box>
  );
};

export default Home;