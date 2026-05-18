-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 18, 2026 at 12:09 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `attendancesystem1_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `attendance`
--

CREATE TABLE `attendance` (
  `attendanceID` int(20) NOT NULL,
  `userID` int(20) NOT NULL,
  `name` varchar(200) NOT NULL,
  `role` varchar(100) NOT NULL,
  `date` date NOT NULL,
  `clockIn` varchar(50) NOT NULL,
  `clockOut` varchar(50) NOT NULL,
  `attendanceStatus` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `attendance`
--

INSERT INTO `attendance` (`attendanceID`, `userID`, `name`, `role`, `date`, `clockIn`, `clockOut`, `attendanceStatus`) VALUES
(2, 2231, 'iman', 'academician', '2025-06-02', '8:00', '17:00', 'Late'),
(4, 3, 'Yaya Amirah Binti Mat', 'Supporting Staff', '2025-06-15', '09:58:28', '10:03:26', 'Absent'),
(5, 33, 'mat', 'Supporting Staff', '2025-06-15', '23:00:44', '23:00:46', 'Late'),
(7, 26, 'haikal danial', 'Academician', '2025-06-16', '18:37:40', '18:39:02', 'Absent'),
(8, 33, 'mat', 'Supporting Staff', '2025-06-17', '03:51:24', '03:51:27', 'Present'),
(9, 34, 'Amir Hakim', 'HRD', '2025-06-10', '08:00', '17:00', 'Present'),
(10, 34, 'Amir Hakim', 'HRD', '2025-06-11', '08:15', '17:00', 'Late'),
(11, 35, 'Nor Alisa', 'Supporting Staff', '2025-06-10', '08:00', '17:00', 'Present'),
(12, 35, 'Nor Alisa', 'Supporting Staff', '2025-06-11', '00:00', '00:00', 'Absent'),
(13, 36, 'Faizal Ridzuan', 'Head of PTJ', '2025-06-10', '08:00', '17:00', 'Present'),
(14, 36, 'Faizal Ridzuan', 'Head of PTJ', '2025-06-11', '08:25', '17:00', 'Late'),
(15, 37, 'Azlin Binti Mat', 'Academician', '2025-06-10', '08:00', '17:00', 'Present'),
(16, 37, 'Azlin Binti Mat', 'Academician', '2025-06-11', '00:00', '00:00', 'Absent'),
(17, 38, 'Rasyid Aiman', 'Supporting Staff', '2025-06-10', '08:30', '17:00', 'Late'),
(18, 38, 'Rasyid Aiman', 'Supporting Staff', '2025-06-11', '08:00', '17:00', 'Present'),
(19, 39, 'Muhammad Syafiq', 'HRD', '2025-06-10', '08:00', '17:00', 'Present'),
(20, 39, 'Muhammad Syafiq', 'HRD', '2025-06-11', '00:00', '00:00', 'Absent'),
(21, 40, 'Ain Fatin', 'Academician', '2025-06-10', '08:00', '17:00', 'Present'),
(22, 40, 'Ain Fatin', 'Academician', '2025-06-11', '08:45', '17:00', 'Late'),
(23, 41, 'Nina Farhana', 'Head of PTJ', '2025-06-10', '08:00', '17:00', 'Present'),
(24, 41, 'Nina Farhana', 'Head of PTJ', '2025-06-11', '08:00', '17:00', 'Present'),
(25, 42, 'Azree Zainal', 'Supporting Staff', '2025-06-10', '08:15', '17:00', 'Late'),
(26, 42, 'Azree Zainal', 'Supporting Staff', '2025-06-11', '00:00', '00:00', 'Absent'),
(27, 43, 'Badrul Hisyam', 'Academician', '2025-06-10', '08:00', '17:00', 'Present'),
(29, 26, 'haikal danial', 'Academician', '2025-06-01', '08:00:00', '17:00:00', 'Present'),
(30, 26, 'haikal danial', 'Academician', '2025-06-02', '08:10:00', '17:00:00', 'Present'),
(31, 26, 'haikal danial', 'Academician', '2025-06-03', '08:00:00', '17:00:00', 'Present'),
(32, 26, 'haikal danial', 'Academician', '2025-06-04', '08:00:00', '17:00:00', 'Present'),
(33, 26, 'haikal danial', 'Academician', '2025-06-05', '08:20:00', '17:00:00', 'Present'),
(34, 26, 'haikal danial', 'Academician', '2025-06-06', '08:00:00', '17:00:00', 'Present'),
(35, 26, 'haikal danial', 'Academician', '2025-06-07', '08:00:00', '17:00:00', 'Present'),
(36, 26, 'haikal danial', 'Academician', '2025-06-08', '08:30:00', '17:00:00', 'Present'),
(37, 26, 'haikal danial', 'Academician', '2025-06-09', '08:00:00', '17:00:00', 'Present'),
(38, 26, 'haikal danial', 'Academician', '2025-06-10', '08:00:00', '17:00:00', 'Present'),
(39, 26, 'haikal danial', 'Academician', '2025-06-11', '08:45:00', '17:00:00', 'Present'),
(40, 26, 'haikal danial', 'Academician', '2025-06-12', '08:00:00', '17:00:00', 'Present'),
(41, 26, 'haikal danial', 'Academician', '2025-06-13', '08:00:00', '17:00:00', 'Present'),
(42, 26, 'haikal danial', 'Academician', '2025-06-14', '08:05:00', '17:00:00', 'Present'),
(43, 26, 'haikal danial', 'Academician', '2025-06-15', '08:00:00', '17:00:00', 'Present'),
(44, 26, 'haikal danial', 'Academician', '2025-06-16', '08:00:00', '17:00:00', 'Present'),
(45, 26, 'haikal danial', 'Academician', '2025-06-17', '08:10:00', '17:00:00', 'Present'),
(46, 26, 'haikal danial', 'Academician', '2025-06-18', '08:00:00', '17:00:00', 'Present'),
(47, 26, 'haikal danial', 'Academician', '2025-06-19', '09:00:00', '17:00:00', 'Present'),
(48, 26, 'haikal danial', 'Academician', '2025-06-20', '08:25:00', '17:00:00', 'Present');

-- --------------------------------------------------------

--
-- Table structure for table `leaveapplication`
--

CREATE TABLE `leaveapplication` (
  `leaveId` int(11) NOT NULL,
  `userID` int(5) NOT NULL,
  `leaveType` varchar(50) NOT NULL,
  `startDate` date NOT NULL,
  `endDate` date NOT NULL,
  `reason` varchar(255) NOT NULL,
  `status` enum('Pending','Approved','Rejected','','') NOT NULL DEFAULT 'Pending',
  `reasonFile` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `leaveapplication`
--

INSERT INTO `leaveapplication` (`leaveId`, `userID`, `leaveType`, `startDate`, `endDate`, `reason`, `status`, `reasonFile`) VALUES
(14, 1, 'Annual Leave(AL)', '2025-05-26', '2025-05-27', 'cough', 'Approved', NULL),
(18, 1, 'Paternity Leave(PL)', '2025-05-27', '2025-05-28', 'wife giving birth', 'Approved', NULL),
(19, 1, 'Annual Leave(AL)', '2025-05-28', '2025-05-29', 'fever', 'Rejected', NULL),
(25, 1, 'Sick Leave(SL)', '2025-06-20', '2025-06-27', 'patah kaki', 'Rejected', 'Gantt Chart.png'),
(26, 1, 'Sick Leave(SL)', '2025-06-14', '2025-06-16', 'patah kaki', 'Rejected', '91e343c3d75d8dc5a42004776fef07da.jpg'),
(27, 1, 'Annual Leave(AL)', '2025-06-14', '2025-06-16', 'patah kaki', 'Approved', 'barbie.jpg'),
(28, 1, 'Maternity Leave(ML)', '2025-06-16', '2025-06-27', 'vacation', 'Approved', 'jacoco-logo.jpeg'),
(29, 1, 'Annual Leave(AL)', '2025-06-16', '2025-06-17', 'vacation', 'Approved', 'jacoco-logo.jpeg'),
(30, 26, 'Unpaid Leave(UL)', '2025-06-25', '2025-06-28', 'mau tidorr', 'Approved', 'WhatsApp Image 2025-05-16 at 16.29.48_f2a0a05d.jpg'),
(31, 26, 'Annual Leave(AL)', '2025-06-16', '2025-06-18', 'vacation', 'Pending', 'jacoco-logo.jpeg'),
(32, 26, 'Annual Leave(AL)', '2025-06-26', '2025-07-01', 'illness', 'Pending', 'download.png'),
(33, 26, 'Annual Leave(AL)', '2025-06-16', '2025-06-26', 'illness', 'Pending', 'WhatsApp Image 2025-05-16 at 16.29.48_cae159d5.jpg'),
(34, 26, 'Annual Leave(AL)', '2025-06-24', '2025-07-05', 'flu', 'Pending', 'download.png'),
(35, 26, 'Annual Leave(AL)', '2025-06-24', '2025-07-05', 'flu', 'Pending', 'download.png'),
(36, 26, 'Unpaid Leave(UL)', '2025-06-16', '2025-06-17', 'efewfewofewfewffewfewfewfew', 'Pending', 'jacoco-logo.jpeg'),
(37, 26, 'Maternity Leave(ML)', '2025-06-25', '2025-06-28', 'gg', 'Pending', 'jacoco-logo.jpeg'),
(38, 26, 'Annual Leave (AL)', '2025-06-17', '2025-06-26', 'tidak ada', 'Approved', 'jacoco-logo.jpeg'),
(39, 26, 'Paternity Leave (PL)', '2025-06-16', '2025-06-28', 'aaaaaaaaaaaa', 'Rejected', 'jacoco-logo.jpeg'),
(40, 35, 'Sick Leave (SL)', '2025-06-20', '2025-06-21', 'mau tidorr la boss', 'Pending', 'download.png'),
(41, 33, 'Sick Leave (SL)', '2025-06-18', '2025-06-19', 'cough', 'Approved', 'download.png'),
(42, 33, 'Sick Leave (SL)', '2025-06-18', '2025-06-20', 'fever', 'Rejected', 'download.png'),
(43, 33, 'Annual Leave (AL)', '2025-06-18', '2025-06-20', 'nak tidur', 'Pending', 'download.png'),
(44, 33, 'Sick Leave (SL)', '2025-06-17', '2025-06-18', 'buat buat sakit', 'Approved', 'UMT_Logo.png'),
(47, 33, 'Annual Leave (AL)', '2025-06-18', '2025-06-25', 'vacation', 'Approved', 'download.png'),
(48, 33, 'Annual Leave (AL)', '2025-06-18', '2025-06-25', 'vacation', 'Approved', 'download.png');

-- --------------------------------------------------------

--
-- Table structure for table `overtime`
--

CREATE TABLE `overtime` (
  `overtimeID` int(255) NOT NULL,
  `userID` int(200) NOT NULL,
  `startTime` time NOT NULL,
  `endTime` time NOT NULL,
  `dateOvertime` date NOT NULL,
  `varification` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `overtime`
--

INSERT INTO `overtime` (`overtimeID`, `userID`, `startTime`, `endTime`, `dateOvertime`, `varification`) VALUES
(2, 33, '00:23:00', '12:23:00', '2025-06-18', 'Approved'),
(3, 33, '13:40:00', '07:40:00', '2025-06-18', 'Rejected'),
(6, 33, '03:49:00', '15:49:00', '2025-06-18', 'Approved'),
(7, 33, '19:23:00', '17:28:00', '2025-06-15', 'Approved'),
(8, 33, '06:37:00', '21:37:00', '2025-06-18', 'Rejected'),
(10, 33, '00:37:00', '12:37:00', '2025-06-18', 'Approved'),
(11, 33, '20:08:00', '21:08:00', '2025-06-25', 'Approved'),
(12, 33, '16:38:00', '18:38:00', '2025-06-19', 'Approved');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `userID` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `fullName` varchar(100) DEFAULT NULL,
  `gender` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `department` varchar(100) DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `role` varchar(50) DEFAULT 'general',
  `profilePic` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`userID`, `username`, `fullName`, `gender`, `email`, `phone`, `address`, `department`, `dob`, `password`, `role`, `profilePic`) VALUES
(3, 'yaya', 'Yaya Amirah Binti Mat', 'female', 'yaya@gmail.com', '013249033', 'kampong pok jin Terengganu', 't', '2007-02-21', 'yaya123', 'Supporting Staff', NULL),
(20, 'azhar', 'Muhammad Azhar Bin Muhamad Nor', 'male', 'azhar04@gmail.com', '01111013816', 'Kg Tok Jembal Terengganu', 'fpm', '2004-05-01', 'azhar123', 'HRD', 'uploads/myBiasTakeTheLastTrain.webp'),
(22, 'wan', 'wan aimi bin abd hamat', 'female', 'aimi@gmail.com', '01124432044', 'kampong pok jin Terengganu', 'fpep', '2025-05-12', 'azhar123', 'Head of PTJ', NULL),
(26, 'haikal', 'haikal danial', 'female', 'haikal@gmail.com', '01111012816', 'kampong pok jin', 'fpep', '2025-05-07', 'yaya123', 'Academician', NULL),
(29, 'azfar', 'Muhammad Azfar Bin Mat', 'Male', 'azfar@gmail.com', '01234532203', 'kampong pok jin Terengganu', 'fskm', '1993-02-01', 'azfar123', 'Supporting Staff', NULL),
(30, 'jaya', 'jaya selan', 'male', 'jaya@gmail.com', '01111012331', 'fleefkepof', 'fpepep', '2025-06-02', 'jaya', 'Head of PTJ', 'uploads/download.png'),
(33, 'mat', 'mat', 'male', 'mat2025@gmail.com', '01111111312', 'kuala nerus', 'fpep', '2025-06-02', 'mat', 'Supporting Staff', 'uploads/jacoco-logo.jpeg'),
(34, 'najmi', 'naim najmi', 'male', 'najmi@gmail.com', '01111111312', 'pak jin', 'fpep', '2025-06-02', 'najmi', 'Academician', NULL),
(35, 'oren', 'oren bin kelabu', 'Male', 'oren@gmail.com', '01111012331', 'fleefkepof', 'ftkk', '2025-06-17', 'oren', 'Academician', NULL),
(38, 'amir01', 'Amir Hakim', 'male', 'amir01@example.com', '0123456789', 'Kuala Terengganu', 'ftkk', '1995-03-15', 'amir123', 'HRD', NULL),
(39, 'lisa92', 'Nor Alisa', 'female', 'lisa92@example.com', '0198765432', 'Dungun, Terengganu', 'fskm', '1992-06-30', 'lisa123', 'Supporting Staff', NULL),
(40, 'faizal87', 'Faizal Ridzuan', 'male', 'faizal87@example.com', '0171234567', 'Kemaman', 'fpep', '1987-09-20', 'faizal123', 'Head of PTJ', NULL),
(41, 'azlin88', 'Azlin Binti Mat', 'female', 'azlin88@example.com', '0189988776', 'Setiu, Terengganu', 'fpm', '1988-02-10', 'azlin123', 'Academician', NULL),
(42, 'rasyid24', 'Rasyid Aiman', 'male', 'rasyid24@example.com', '0135556677', 'Marang', 'ftkk', '1999-12-05', 'rasyid123', 'Supporting Staff', NULL),
(43, 'syafiq01', 'Muhammad Syafiq', 'male', 'syafiq01@example.com', '0141239876', 'Besut', 'fskm', '1996-07-18', 'syafiq123', 'HRD', NULL),
(44, 'ain92', 'Ain Fatin', 'female', 'ain92@example.com', '0129988776', 'Kuala Nerus', 'fpep', '1992-01-22', 'ain123', 'Academician', NULL),
(46, 'azree07', 'Azree Zainal', 'male', 'azree07@example.com', '0112233445', 'Hulu Terengganu', 'ftkk', '1990-04-01', 'azree123', 'Supporting Staff', NULL),
(47, 'badrul95', 'Badrul Hisyam', 'male', 'badrul95@example.com', '0103344556', 'Ajil, Terengganu', 'fskm', '1995-11-09', 'badrul123', 'Academician', NULL),
(48, 'faz', 'faz', 'female', 'faz@gmail.com', '0123456789', 'umt', 'umt', '2025-12-12', 'azhar123', 'Supporting Staff', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `working_days`
--

CREATE TABLE `working_days` (
  `yearMonth` varchar(7) NOT NULL,
  `total_working_days` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `working_days`
--

INSERT INTO `working_days` (`yearMonth`, `total_working_days`) VALUES
('2025-01', 22),
('2025-02', 19),
('2025-03', 21),
('2025-04', 20),
('2025-05', 20),
('2025-06', 21),
('2025-07', 22),
('2025-08', 21),
('2025-09', 21),
('2025-10', 22),
('2025-11', 20),
('2025-12', 22);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `attendance`
--
ALTER TABLE `attendance`
  ADD PRIMARY KEY (`attendanceID`);

--
-- Indexes for table `leaveapplication`
--
ALTER TABLE `leaveapplication`
  ADD PRIMARY KEY (`leaveId`);

--
-- Indexes for table `overtime`
--
ALTER TABLE `overtime`
  ADD PRIMARY KEY (`overtimeID`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`userID`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `working_days`
--
ALTER TABLE `working_days`
  ADD PRIMARY KEY (`yearMonth`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `attendance`
--
ALTER TABLE `attendance`
  MODIFY `attendanceID` int(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=49;

--
-- AUTO_INCREMENT for table `leaveapplication`
--
ALTER TABLE `leaveapplication`
  MODIFY `leaveId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=49;

--
-- AUTO_INCREMENT for table `overtime`
--
ALTER TABLE `overtime`
  MODIFY `overtimeID` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `userID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=50;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
