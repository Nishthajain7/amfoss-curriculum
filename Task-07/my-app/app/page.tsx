import Link from "next/link";
import Image from 'next/image'
import movies from "../public/data.json"
import styles from "./styles/Home.module.css";
import Form from 'next/form'
import { FaBars } from "react-icons/fa6";


export default function Home() {
  return (
    <main>
      <div className="topBar">

        <Link href="profile" className="link"><FaBars /></Link>
        <Form action="/search" className="searchbox"><input name="query" /></Form>

      </div>

      <div className="contents">
        <div className={styles.moviesGrid}>
          {movies.map((movie) => (
            <div key={movie.id} className={styles.movieHolder}>
              <Image src={movie.image} alt={movie.name} width={200} height={300} unoptimized={true} />
              <h2>{movie.name}</h2>
              <p>Released: {movie.year}</p>
            </div>
          ))}
        </div>
      </div>
    </main>
  );
}