SELECT
    cm.ClubMembershipNumber AS club_membership_number,
    cm.FirstName AS first_name,
    cm.LastName AS last_name,
    YEAR(CURDATE()) - YEAR(cm.DateOfBirth) AS age,
    cm.TelephoneNumber AS phone_number,
    fm.EmailAddress AS email,
    l.Name AS location_name
FROM ClubMembers cm
JOIN ClubMemberLocations cml ON cm.ClubMemberID = cml.ClubMemberID
JOIN Location l ON cml.LocationID = l.LocationID
JOIN FamilyRelated fr ON cm.ClubMemberID = fr.ClubMemberID
JOIN FamilyMember fm ON fr.FamilyMemberID = fm.FamilyMemberID
WHERE cm.Status = 'Active'
    AND EXISTS (
        SELECT 1
        FROM ClubMemberTeams cmt2
        WHERE cmt2.ClubMemberID = cm.ClubMemberID
        AND cm.Role = 'GoalKeeper'
    )
    AND EXISTS (
        SELECT 1
        FROM ClubMemberTeams cmt3
        WHERE cmt3.ClubMemberID = cm.ClubMemberID
        AND cm.Role = 'Defender'
    )
    AND EXISTS (
        SELECT 1
        FROM ClubMemberTeams cmt4
        WHERE cmt4.ClubMemberID = cm.ClubMemberID
        AND cm.Role = 'Midfielder'
    )
    AND EXISTS (
        SELECT 1
        FROM ClubMemberTeams cmt5
        WHERE cmt5.ClubMemberID = cm.ClubMemberID
        AND cm.Role = 'Forward'
    )
ORDER BY l.Name ASC, cm.ClubMembershipNumber ASC;
