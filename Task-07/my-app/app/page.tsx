'use client'
import { useState } from "react";
import Link from "next/link";
import Image from 'next/image'
import movies from "../public/movies.json"
import styles from "./styles/Home.module.css";
import { FaBars } from "react-icons/fa6";
import { LiaCommentSolid } from "react-icons/lia";
import { CgProfile } from "react-icons/cg";
import { FaClipboardList } from "react-icons/fa";

export default function Home() {
  const [menuOpen, setMenuOpen] = useState(false);

  const toggleMenu = () => {
    setMenuOpen(!menuOpen);
  };

  return (
    <main>
      
      <div className="topBar">
        <button className="icon" onClick={toggleMenu}><FaBars /></button>
        <input id="search" name="query" placeholder="Search for a movie" />
      </div>

      <div className={`optionsMenu ${menuOpen ? "open" : ""}`}>

        <Link href="profile" className="option">
          <div className="icon"><CgProfile /></div>
          Profile
        </Link>
        <Link href="watchlist" className="option">
          <div className="icon"><FaClipboardList /></div>
          <p>Watchlist</p>
        </Link>
        <Link href="recentActivity" className="option">
          <div className="icon"><LiaCommentSolid /></div>
          <p>Recent activity</p>
        </Link>

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