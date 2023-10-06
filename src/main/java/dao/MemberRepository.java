package dao;
import java.util.*;
import dto.Member;

public class MemberRepository {
	private final ArrayList<Member> members = new ArrayList<>();
	private static final MemberRepository instance = new MemberRepository();
	
	public static MemberRepository getInstance() {
		return instance;
	}
	
	public Member getMemberById(String memberId) {
		Member member = null;
		
		// foreach로 목록 순회
		for(Member p : members) {
			if(p.getMemberId().equals(memberId)) {
				// 매개변수와 객체의 Id가 같으면
				member = p;
				break;
			}
		}
		return member;
	}
	
	public void addMember(Member member) {
		members.add(member);
	}
}
