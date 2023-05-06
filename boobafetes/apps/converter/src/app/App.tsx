import { iaHandler } from '@boobafetes/ia-handler';
import { Link, Route, Routes } from 'react-router-dom';

export function App() {
  return (
    <div>
      <div role="navigation">
        <ul>
          <li>
            <Link to="/">Home</Link>
          </li>
          <li>
            <Link to="/page-2">Page 2</Link>
          </li>
          <li>
            <Link to="/ia-handler">IA handler</Link>
          </li>
        </ul>
      </div>
      <Routes>
        <Route
          path="/"
          element={
            <div>
              This is the generated root route.{' '}
              <Link to="/page-2">Click here for page 2.</Link>
              <Link to="/ia-handler">go to ia handler demo.</Link>
            </div>
          }
        />
        <Route
          path="/page-2"
          element={
            <div>
              <Link to="/">Click here to go back to root page.</Link>
            </div>
          }
        />
        <Route
          path="/ia-handler"
          element={
            <div>
              <div>
                <Link to="/">Click here to go back to root page.</Link>
              </div>
              <div>
                <p>
                  <label>ia handler says :</label>
                </p>
                <p>{iaHandler()}</p>
              </div>
            </div>
          }
        />
      </Routes>
    </div>
  );
}

export default App;
