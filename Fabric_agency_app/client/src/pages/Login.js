import styled from "styled-components";
import { useState } from "react";
import { useDispatch, useSelector } from "react-redux";
import {login} from '../slices/apiCalls'
import { useHistory, Redirect } from 'react-router-dom';

const Container = styled.div`
  width: 100vw;
  height: 100vh;
  background-size: cover;
  display: flex;
  align-items: center;
  justify-content: center;
  background: slategray;
`;

const Wrapper = styled.div`
  width: 25%;
  padding: 20px;
  background-color: white;
`;

const Title = styled.h1`
  font-size: 24px;
  font-weight: 300;
`;

const Form = styled.form`
  display: flex;
  flex-direction: column;
`;

const Input = styled.input`
  flex: 1;
  min-width: 40%;
  margin: 10px 0;
  padding: 10px;
`;

const Button = styled.button`
  width: 40%;
  border: none;
  padding: 15px 20px;
  background-color: teal;
  color: white;
  cursor: pointer;
  margin-bottom: 10px;
  &:disabled{
    cursor: not-allowed;
  }
`;

const Error =styled.span`
  color: red;
` 

const Link = styled.a`
  margin: 5px 0px;
  font-size: 12px;
  text-decoration: underline;
  cursor: pointer;
`;

const Login = () => {
  const history = useHistory();
  const [username, setUsername] = useState("");
  const [password, setPassword] = useState("");
  const {isFetching, error, currentUser} = useSelector(state => state.user)
  const dispatch = useDispatch();

console.log(error)

  const handleClick = async (e) => {
    e.preventDefault();
    await login(dispatch, {username: username, password: password});
    if(error == false)
    {
      console.log("success");
    }
  }

  return (
    <Container>
      <Wrapper>
        <Title>SIGN IN</Title>
        <Form>
          <Input placeholder="Username" onChange={(e) => setUsername(e.target.value)}/>
          <Input placeholder="Password" type="password" onChange={(e) => setPassword(e.target.value)}/>
          {error && <Error>Something went wrong!</Error>}
          <Button onClick={handleClick}>LOGIN</Button>
        </Form>
      </Wrapper>
    </Container>
  );
};

export default Login;