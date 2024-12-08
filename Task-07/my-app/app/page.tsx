import Link from "next/link";
import Image from 'next/image'
import movies from "../public/data.json"
import styles from "./styles/Home.module.css";
import Form from 'next/form'
import { FaBars } from "react-icons/fa6";
import { FaHome } from "react-icons/fa";
import { LiaCommentSolid } from "react-icons/lia";
import { TbStar } from "react-icons/tb";
import { CgProfile } from "react-icons/cg";
import { FaClipboardList } from "react-icons/fa";

export default function Home() {
  return (
    <main>
      <div className="topBar">

        <div className="icon"><FaBars /></div>
        <input name="query" placeholder="Search for a movie" />
      </div>

      {/* <div className="optionsMenu">

        <Link href="profile" className="option">
          <div className="icon"><CgProfile /></div>
          Profile
        </Link>
        <Link href="watchlist" className="option">
          <div className="icon"><FaClipboardList /></div>
          <p>Watchlist</p>
        </Link>
        <Link href="comments" className="option">
          <div className="icon"><LiaCommentSolid /></div>
          <p>My Comments</p>
        </Link>
        <Link href="ratings" className="option">
          <div className="icon"><TbStar /></div>
          <p>My Ratings</p>
        </Link>

      </div> */}

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