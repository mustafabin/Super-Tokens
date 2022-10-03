import { useState } from "react";
import { CopyBlock, dracula } from "react-code-blocks";
import reactLogo from "./assets/react.svg";
import "./App.css";

function App() {
  const [response, setResponse] = useState("Enter login info         ");
  const [profileResponse, setProfileResponse] = useState(
    "Enter Token          "
  );
  let handleSubmit = (e: any) => {
    e.preventDefault();
    let email: string = e.target["email"].value;
    let password: string = e.target["password"].value;
    fetch("http://10.129.3.3:3000/login", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify({ email: email, password: password }),
    })
      .then((res) => res.json())
      .then((data) => setResponse(JSON.stringify(data, null, 2)));
  };
  let handleProfile = (e: any) => {
    e.preventDefault();
    let token: string = e.target["token"].value;
    fetch("http://10.129.3.3:3000/profile", {
      headers: {
        "Content-Type": "application/json",
        SuperToken: token,
      },
    })
      .then((res) => res.json())
      .then((data) => setProfileResponse(JSON.stringify(data, null, 2)));
  };
  return (
    <div className="App">
      <div style={{ marginTop: "10rem" }}>
        <a href="https://vitejs.dev" target="_blank">
          <img src="/vite.svg" className="logo" alt="Vite logo" />
        </a>
        <a href="https://reactjs.org" target="_blank">
          <img src={reactLogo} className="logo react" alt="React logo" />
        </a>
      </div>
      <form onSubmit={handleSubmit}>
        <h1>Login</h1>
        <input name="email" placeholder="Email" type="text" />
        <input name="password" placeholder="Password" type="text" />
        <button type="submit">Submit</button>
      </form>
      <p className="read-the-docs">response</p>
      <CopyBlock
        language={"JSON"}
        text={response}
        showLineNumbers={true}
        theme={dracula}
        wrapLines={true}
        codeBlock
      />
      <form onSubmit={handleProfile}>
        <h1>Profile</h1>
        <input name="token" placeholder="Token" type="text" />
        <button type="submit">Submit</button>
      </form>
      <p className="read-the-docs">response</p>
      <CopyBlock
        language={"JSON"}
        text={profileResponse}
        showLineNumbers={true}
        theme={dracula}
        wrapLines={true}
        codeBlock
        style={{ maxWidth: "100vw" }}
      />
    </div>
  );
}

export default App;
