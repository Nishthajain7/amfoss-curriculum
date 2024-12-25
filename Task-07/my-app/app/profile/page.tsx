import styles from "./profile.module.css";
import details from "../../public/accounts.json"

const UsersPage = () => {
  return (
    <main className={styles.main}>

      <div className={styles.details}>
        {details.map((detail) => (
          <div className={styles.container}>
            <h1>Account Details</h1>
            <div className={styles.content}>
                <p className={styles.keys}>First Name</p>
                <p className={styles.values}>{detail["Account Details"]["First Name"]}</p>
                <p className={styles.keys}>Last name</p>
                <p className={styles.values}>{detail["Account Details"]["Last Name"]}</p>
            </div>
          </div>))}

        {details.map((detail) => (
          <div className={styles.container}>
            <h1>Contact Details</h1>
            <div className={styles.content}>
                <p className={styles.keys}>E-mail</p>
                <p className={styles.values}>{detail["Contact Details"]["E-mail"]}</p>
                <p className={styles.keys}>Mobile Number</p>
                <p className={styles.values}>{detail["Contact Details"]["Mobile number"]}</p>
                <p className={styles.keys}>Whatsapp Number</p>
                <p className={styles.values}>{detail["Contact Details"]["Whatsapp number"]}</p>
            </div>
          </div>
        ))}
        {details.map((detail) => (
          <div className={styles.container}>
            <h1>Personal Details</h1>
            <div className={styles.content}>
                <p className={styles.keys}>Birthday</p>
                <p className={styles.values}>{detail["Personal Details"]["Birthday"]}</p>
                <p className={styles.keys}>Identity</p>
                <p className={styles.values}>{detail["Personal Details"]["Identity"]}</p>
            </div>
          </div>
        ))}
      </div>

    </main>
  )
}

export default UsersPage